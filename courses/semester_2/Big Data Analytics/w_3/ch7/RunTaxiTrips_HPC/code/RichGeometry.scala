import scala.language.implicitConversions

/**
 * A wrapper that provides convenience methods for using the spatial relations in the ESRI
 * GeometryEngine with a particular instance of the Geometry interface and an associated
 * SpatialReference.
 *
 * @param geometry         the geometry object
 * @param spatialReference optional spatial reference; if not specified, uses WKID 4326 a.k.a.
 *                         WGS84, the standard coordinate frame for Earth.
 */
class RichGeometry(
  val geometry:         com.esri.core.geometry.Geometry,
  val spatialReference: com.esri.core.geometry.SpatialReference = com.esri.core.geometry.SpatialReference.create(4326)) extends Serializable {

  def area2D(): Double = geometry.calculateArea2D()

  def distance(other: com.esri.core.geometry.Geometry): Double = {
    com.esri.core.geometry.GeometryEngine.distance(geometry, other, spatialReference)
  }

  def contains(other: com.esri.core.geometry.Geometry): Boolean = {
    com.esri.core.geometry.GeometryEngine.contains(geometry, other, spatialReference)
  }

  def within(other: com.esri.core.geometry.Geometry): Boolean = {
    com.esri.core.geometry.GeometryEngine.within(geometry, other, spatialReference)
  }

  def overlaps(other: com.esri.core.geometry.Geometry): Boolean = {
    com.esri.core.geometry.GeometryEngine.overlaps(geometry, other, spatialReference)
  }

  def touches(other: com.esri.core.geometry.Geometry): Boolean = {
    com.esri.core.geometry.GeometryEngine.touches(geometry, other, spatialReference)
  }

  def crosses(other: com.esri.core.geometry.Geometry): Boolean = {
    com.esri.core.geometry.GeometryEngine.crosses(geometry, other, spatialReference)
  }

  def disjoint(other: com.esri.core.geometry.Geometry): Boolean = {
    com.esri.core.geometry.GeometryEngine.disjoint(geometry, other, spatialReference)
  }
}

/**
 * Helper object to implicitly create RichGeometry wrappers for a given Geometry instance.
 */
object RichGeometry extends Serializable {
  implicit def createRichGeometry(g: com.esri.core.geometry.Geometry): RichGeometry = new RichGeometry(g)
}
