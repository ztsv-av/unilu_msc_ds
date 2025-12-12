// Online SCALA can be found here https://scastie.scala-lang.org/
// Defining variables

var x:Int = 7

var x = 7

val y = "hi"

// Defining tuples

var x = (4, 5)

// Defining functions

def square(x: Int): Int = x*x // no braces, only single instruction

def square(x: Int): Int = { x*x } // with braces, mulitple instructions possible

def announce(text: String) =
{ println(text)
  println("Length: "
      + text.length())
}

// Variables as (anonymous) functions

var timesTwo = (i:Int) => i * 2

// Functions with no arguments

def x = 5

// Functions with multiple argument lists

def foo(a: Int*)(b: Int*)(c: Int*) = a.sum * b.sum * c.sum
foo(1, 2, 3)(4, 5, 6, 7, 9)(10, 11)

// Functions with anonymous arguments

val list = List(1, 2, 3)

list.filter(_ % 2 == 1)

list.map(_ + 2)

list.reduce(_ + _)


list.fold(0)(_ + _)

list.groupBy(_ % 2 == 1)

list.groupBy(_ % 2 == 1).values.flatten

// Defining objects (as containers for functions and variables)

object HelloWorld {
  def main(args: Array[String]) {
    println("Hello, world!") }
}

HelloWorld.main(new Array[String](0))
HelloWorld.main(Array())

object TimerAnonymous {
  def oncePerSecond(callback: () => Unit) {
    while (true) { callback(); Thread sleep 1000 } }
  def main(args: Array[String]) {
    oncePerSecond(() =>
      println("time flies like an arrow...")) }
}

TimerAnonymous.main(Array())

// Case classes and their usage

abstract class Expression
case class Sum(l: Expression, r: Expression) extends Expression
case class Neg(n: Expression) extends Expression
case class Const(v: Int) extends Expression

val myExpr = Sum(Const(7), Neg(Const(5)))

def eval(t: Expression): Int = t match {
  case Sum(l, r) => eval(l) + eval(r)
  case Neg(n) => -1 * eval(n)
  case Const(v) => v
}
println(eval(myExpr))

// Trait usage in Scala (similar to interfaces in Java)

trait Ord {
    def <  (that: Any): Boolean
    def <= (that: Any): Boolean =  (this <  that) || (this == that)
    def >  (that: Any): Boolean = !(this <= that)
    def >= (that: Any): Boolean = !(this <  that) }

class Date(y: Int, m: Int, d: Int) extends Ord {
  def year = y
  def month = m
  def day = d
  override def toString(): String = year + "-" + month + "-" + day
  override def equals(that: Any): Boolean =
    that.isInstanceOf[Date] && {
      val o = that.asInstanceOf[Date]
      o.day == day && o.month == month && o.year == year
    }
  def < (that: Any): Boolean = {
    if (!that.isInstanceOf[Date])
      sys.error("cannot compare " + that + " and a Date")

    val o = that.asInstanceOf[Date]
    (year < o.year) || (year == o.year && (month < o.month || (month == o.month && day < o.day)))
  }
}

// Multiple inheritance among traits

trait MyTraitA extends Any {
  var n:Any; override def toString() = "MyTraitA: " + n}

trait MyTraitB extends Any {
  var n:Any; override def toString() = "MyTraitB: " + n}

trait MyTraitC extends Any {
  var n:Any; override def toString() = "MyTraitC: " + n}

class MyClass(a:Any) extends MyTraitA with MyTraitB with MyTraitC {
  var n = a // must overwrite members from trait
  //override def toString() = "MyClass: " + n // enable to overwrite
}

println(new MyClass(777))

// Basic RDD usage (requires a running Spark shell!)

val rdd = sc.parallelize(List(1, 2, 3, 3))
val other = sc.parallelize(List(3, 4, 5))

rdd.flatMap(x => x.to(3))

rdd.union(other)

val x = rdd.aggregate((0, 0)) ((x, y) => (x._1 + y, x._2 + 1), (x, y) => (x._1 + y._1, x._2 + y._2))
val avg = x._1.toDouble/x._2

// Advanced example for combineByKey (computes the global average of an RDD's values in a distributed fashion)

val rdd = sc.parallelize(Seq((1, 2), (3, 4), (3, 6)))
val result = rdd.combineByKey(
  (v) => (v, 1),
  (acc: (Int, Int), v) => (acc._1 + v, acc._2 + 1),
  (acc1: (Int, Int), acc2: (Int, Int)) => (acc1._1 + acc2._1,
       acc1._2 + acc2._2)
  ).map{ case (key, value) => (key, value._1 / value._2.toFloat) }
result.collectAsMap().map(println(_))

// Defining accumulator variables and their usage

val file = sc.textFile("./derby.log")
val errorCodes = sc.broadcast(Array("401", "404", "500", "502"))
val errorLines = sc.accumulator(0)
val callSigns = file.flatMap(line => {
  for (e <- errorCodes.value) {
    if (line.contains(e)) {
      errorLines += 1 // Add to the accumulator
    }
  }
  line.split(" ")
})
callSigns.saveAsTextFile("./results5.txt")
println("Error lines: " + errorLines.value)
