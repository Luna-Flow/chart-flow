///|
type Point2D (Double, Double)

///|
// enum Shape {
//   Circle(Point2D, Double)
//   Rectangle(Point2D, Point2D)
//   Polygon(Array[Point2D])
//   Line(Point2D, Point2D)
//   Text(Point2D, String)
// }

///|
enum ScatterType {
  //ScatterType size
  Circle(UInt)
  Square(UInt)
  Triangle(UInt)
  Diamond(UInt)
  Cross(UInt)
  X(UInt)
  Star(UInt)
}

///|
enum ScatterStyle {
  ScatterStyle(ScatterType, Color)
}

///|
enum LineType {
  //Solid width
  Solid(UInt)
  //Dot width gap
  Dot(UInt, Double)
  //Dash width length gap
  Dash(UInt, Double, Double)
}

///|
enum LineStyle {
  LineStyle(LineType, Color)
  LineStyleWithMarker(LineStyle, ScatterStyle)
}

///|
enum BarStyle {
  //BarStyle stroke_width stroke fill
  BarStyle(UInt, Color, Color)
}

///|
enum TextStyle {
  //TextStyle size font color
  TextStyle(UInt, String, Color)
}

///|
enum Trace {
  //Trace name font? data style
  LineTrace(String, TextStyle?, Array[Point2D], LineStyle)
  ScatterTrace(String, TextStyle?, Array[Point2D], ScatterStyle)
  BarTrace(String, TextStyle?, Array[Point2D], BarStyle)
}

///|
enum AxisType {
  //AxisType unit
  Linear(String)
  Log(String)
}

///|
struct AxisConfig {
  label : (String, TextStyle?)?
}

///|
struct Chart {
  title : (String, TextStyle?)?
  trace : Array[Trace]
  x_axis : AxisType?
  y_axis : AxisType?
}
