import com.esri.core.geometry.{ GeometryEngine, SpatialReference, Geometry, Point }
import com.github.nscala_time.time.Imports.{ DateTime, Duration }

import GeoJsonProtocol._ // this contains our custom GeoJson types

import java.text.SimpleDateFormat

import org.apache.spark.{ HashPartitioner, Partitioner }
import org.apache.spark.rdd.RDD
import org.apache.spark.{ SparkConf, SparkContext }
import org.apache.spark.util.StatCounter

import scala.collection.mutable.ArrayBuffer
import scala.reflect.ClassTag

import spray.json._

object RunTaxiTrips {

  def main(args: Array[String]): Unit = {

    val dataDirectory = args(0)
    val sampleSize = args(1).toDouble
    
    val conf = new SparkConf()
      .setMaster("local")
      .setAppName("RunTaxiTrips")

    val sc = new SparkContext(conf)
    sc.setLogLevel("ERROR")

    val formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")

    def point(longitude: String, latitude: String): Point = {
      new Point(longitude.toDouble, latitude.toDouble)
    }

    case class TaxiTrip(
      pickupTime:  org.joda.time.DateTime,
      dropoffTime: org.joda.time.DateTime,
      pickupLoc:   com.esri.core.geometry.Point,
      dropoffLoc:  com.esri.core.geometry.Point)

    def parse(line: String): (String, TaxiTrip) = {
      val fields = line.split(',')
      val license = fields(1)
      val pickupTime = new org.joda.time.DateTime(formatter.parse(fields(5)))
      val dropoffTime = new org.joda.time.DateTime(formatter.parse(fields(6)))
      val pickupLoc = point(fields(10), fields(11))
      val dropoffLoc = point(fields(12), fields(13))
      val trip = TaxiTrip(pickupTime, dropoffTime, pickupLoc, dropoffLoc)
      (license, trip)
    }

    def safe[S, T](f: S => T): S => Either[T, (S, Exception)] = {
      new Function[S, Either[T, (S, Exception)]] with Serializable {
        def apply(s: S): Either[T, (S, Exception)] = {
          try {
            Left(f(s))
          } catch {
            case e: Exception => Right((s, e))
          }
        }
      }
    }

    //----------------- Parse & Filter the Taxi Trips -------------------------

    val taxiRaw = sc.textFile(dataDirectory + "/nyc-taxi-trips").sample(false, sampleSize) // use 1 percent sample size for debugging!
    val taxiParsed = taxiRaw.map(safe(parse))
    taxiParsed.cache()

    val taxiBad = taxiParsed.collect({
      case t if t.isRight => t.right.get
    })

    val taxiGood = taxiParsed.collect({
      case t if t.isLeft => t.left.get
    })
    taxiGood.cache() // cache good lines for later re-use

    println("\n" + taxiGood.count() + " taxi trips parsed.")
    println(taxiBad.count() + " taxi trips dropped.")

    def getHours(trip: TaxiTrip): Long = {
      val d = new Duration(
        trip.pickupTime,
        trip.dropoffTime)
      d.getStandardHours
    }

    println("\nDistribution of trip durations in hours:")
    taxiGood.values.map(getHours).countByValue().
      toList.sorted.foreach(println)

    val taxiClean = taxiGood.filter {
      case (lic, trip) =>
        val hrs = getHours(trip)
        0 <= hrs && hrs < 3
    }

    val taxiDone = taxiClean.filter {
      case (lic, trip) =>
        val zero = new Point(0.0, 0.0)
        !(zero.equals(trip.pickupLoc) || zero.equals(trip.dropoffLoc))
    }
    taxiDone.cache()

    //----------------- Parse the NYC Boroughs Polygons -----------------------

    val geojson = scala.io.Source.
      fromFile(dataDirectory + "/nyc-borough-boundaries-polygon.geojson").mkString

    val features = geojson.parseJson.convertTo[FeatureCollection]

    // look up the borough for some test point
    val p = new Point(-73.994499, 40.75066)
    val b = features.find(f => f.geometry.contains(p))

    val areaSortedFeatures = features.sortBy(f => {
      val borough = f("boroughCode").convertTo[Int]
      (borough, -f.geometry.area2D())
    })

    val bFeatures = sc.broadcast(areaSortedFeatures)

    def borough(trip: TaxiTrip): Option[String] = {
      val feature: Option[Feature] = bFeatures.value.find(f => {
        f.geometry.contains(trip.dropoffLoc)
      })
      feature.map(f => {
        f("borough").convertTo[String]
      })
    }

    println("\nDistribution of trips per borough:")
    taxiClean.values.map(borough).countByValue().foreach(println)

    def hasZero(trip: TaxiTrip): Boolean = {
      val zero = new Point(0.0, 0.0)
      (zero.equals(trip.pickupLoc) || zero.equals(trip.dropoffLoc))
    }

    //----------------- Helper Classes for "Sessionization" -------------------

    class FirstKeyPartitioner[K1, K2](partitions: Int) extends org.apache.spark.Partitioner {
      val delegate = new org.apache.spark.HashPartitioner(partitions)
      override def numPartitions: Int = delegate.numPartitions
      override def getPartition(key: Any): Int = {
        val k = key.asInstanceOf[(K1, K2)]
        delegate.getPartition(k._1)
      }
    }

    def secondaryKey(trip: TaxiTrip) = trip.pickupTime.getMillis

    def split(t1: TaxiTrip, t2: TaxiTrip): Boolean = {
      val p1 = t1.pickupTime
      val p2 = t2.pickupTime
      val d = new Duration(p1, p2)
      d.getStandardHours >= 4
    }

    def groupSorted[K, V, S](
      it:        Iterator[((K, S), V)],
      splitFunc: (V, V) => Boolean): Iterator[(K, List[V])] = {
      val res = List[(K, ArrayBuffer[V])]()
      it.foldLeft(res)((list, next) => list match {
        case Nil =>
          val ((lic, _), trip) = next
          List((lic, ArrayBuffer(trip)))
        case cur :: rest =>
          val (curLic, trips) = cur
          val ((lic, _), trip) = next
          if (!lic.equals(curLic) || splitFunc(trips.last, trip)) {
            (lic, ArrayBuffer(trip)) :: list
          } else {
            trips.append(trip)
            list
          }
      }).map { case (lic, buf) => (lic, buf.toList) }.iterator
    }

    def groupByKeyAndSortValues[K: Ordering: ClassTag, V: ClassTag, S: Ordering](
      rdd:              RDD[(K, V)],
      secondaryKeyFunc: V => S,
      splitFunc:        (V, V) => Boolean,
      numPartitions:    Int): RDD[(K, List[V])] = {
      val presess = rdd.map {
        case (lic, trip) => ((lic, secondaryKeyFunc(trip)), trip)
      }
      val partitioner = new FirstKeyPartitioner[K, S](numPartitions)
      presess.repartitionAndSortWithinPartitions(partitioner).mapPartitions(groupSorted(_, splitFunc))
    }

    val sessions = groupByKeyAndSortValues(taxiDone, secondaryKey, split, 30) // use fixed amount of 30 partitions
    sessions.cache()

    println("\nSome sample sessions:")
    sessions.take(5).foreach(println)

    //----------------- Final Analysis of the Trip Durations ------------------

    def boroughDuration(t1: TaxiTrip, t2: TaxiTrip) = {
      val b = borough(t1)
      val d = new Duration(t1.dropoffTime, t2.pickupTime)
      (b, d)
    }

    val boroughDurations: RDD[(Option[String], Duration)] =
      sessions.values.flatMap(trips => {
        val iter: Iterator[Seq[TaxiTrip]] = trips.sliding(2)
        val viter = iter.filter(_.size == 2)
        viter.map(p => boroughDuration(p(0), p(1)))
      }).cache()

    println("\nDistribution of wait-times in hours:")
    boroughDurations.values.map(_.getStandardHours).countByValue().toList.
      sorted.foreach(println)

    println("\nFinal stats of wait-times per borough:")
    boroughDurations.filter {
      case (b, d) => d.getMillis >= 0
    }.mapValues(d => {
      val s = new StatCounter()
      s.merge(d.getStandardSeconds)
    }).
      reduceByKey((a, b) => a.merge(b)).collect().foreach(println)
  }
}