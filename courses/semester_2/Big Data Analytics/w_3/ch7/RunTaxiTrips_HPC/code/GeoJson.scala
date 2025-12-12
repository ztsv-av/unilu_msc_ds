import com.esri.core.geometry.Geometry
import com.esri.core.geometry.GeometryEngine
import spray.json._

case class Feature(
  id:         Option[spray.json.JsValue],
  properties: Map[String, spray.json.JsValue],
  geometry:   RichGeometry) extends Serializable {
  def apply(property: String) = properties(property)
  def get(property: String): Option[spray.json.JsValue] = properties.get(property)
}

case class FeatureCollection(features: Array[Feature]) extends IndexedSeq[Feature] with Serializable {
  def apply(index: Int) = features(index)
  def length: Int = features.length
}

case class GeometryCollection(geometries: Array[RichGeometry]) extends IndexedSeq[RichGeometry] with Serializable {
  def apply(index: Int) = geometries(index)
  def length: Int = geometries.length
}

object GeoJsonProtocol extends DefaultJsonProtocol with Serializable {
  implicit object RichGeometryJsonFormat extends RootJsonFormat[RichGeometry] with Serializable {
    def write(g: RichGeometry): JsValue = {
      GeometryEngine.geometryToGeoJson(g.spatialReference, g.geometry).parseJson
    }

    def read(value: spray.json.JsValue): RichGeometry = {
      val mg = GeometryEngine.geometryFromGeoJson(value.compactPrint, 0, Geometry.Type.Unknown)
      new RichGeometry(mg.getGeometry, mg.getSpatialReference)
    }
  }

  implicit object FeatureJsonFormat extends RootJsonFormat[Feature] with Serializable {
    def write(f: Feature): JsObject = {
      val buf = scala.collection.mutable.ArrayBuffer(
        "type" -> JsString("Feature"),
        "properties" -> JsObject(f.properties),
        "geometry" -> f.geometry.toJson)
      f.id.foreach(v => { buf += "id" -> v })
      JsObject(buf.toMap)
    }

    def read(value: spray.json.JsValue): Feature = {
      val jso = value.asJsObject
      val id = jso.fields.get("id")
      val properties = jso.fields("properties").asJsObject.fields
      val geometry = jso.fields("geometry").convertTo[RichGeometry]
      Feature(id, properties, geometry)
    }
  }

  implicit object FeatureCollectionJsonFormat extends RootJsonFormat[FeatureCollection] with Serializable {
    def write(fc: FeatureCollection): JsObject = {
      JsObject(
        "type" -> JsString("FeatureCollection"),
        "features" -> JsArray(fc.features.map(_.toJson): _*))
    }

    def read(value: spray.json.JsValue): FeatureCollection = {
      FeatureCollection(value.asJsObject.fields("features").convertTo[Array[Feature]])
    }
  }

  implicit object GeometryCollectionJsonFormat extends RootJsonFormat[GeometryCollection] with Serializable {
    def write(gc: GeometryCollection): JsObject = {
      JsObject(
        "type" -> JsString("GeometryCollection"),
        "geometries" -> JsArray(gc.geometries.map(_.toJson): _*))
    }

    def read(value: spray.json.JsValue): GeometryCollection = {
      GeometryCollection(value.asJsObject.fields("geometries").convertTo[Array[RichGeometry]])
    }
  }
}
