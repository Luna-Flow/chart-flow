//Generic Props
///|
pub(all) enum Color {
  RGB(UInt, UInt, UInt)
  ColorDimension(Array[UInt])
}

//Font Props
///|
pub(all) enum FontStyle {
  Normal
  Italic
  Bold
}

///|
pub(all) enum LinePosition {
  Under
  Over
  Through
}

//Marker Props
///|
pub(all) enum Symbol {
  Circle
  Square
  Diamond
  Triangle
  Hexagon
  Octagon
  Star
  Bowtie
  Open
  X
  Cross
  Dot
}

//Line Props
///|
pub(all) enum Dash {
  Solid
  Dash
  Dot
  DashDot
  LongDash
  LongDashDot
}

///|
pub(all) enum Shape {
  Linear
  Spline
  HV
  VH
  HVH
  VHV
}

//Basic Components
///|
pub(all) struct Marker {
  symbol : Symbol
  size : UInt
  color : Color
  color_scale : (Color, Color) //(lowest, highest)
  opacity : Float
}

///|
pub(all) struct Line {
  width : UInt
  dash : Dash
  shape : Shape
  smoothing : Float //[0, 1.3]
  color : Color
  opacity : Float
}

///|
pub(all) struct Font {
  line_pos : LinePosition
  family : String
  size : UInt
  color : Color
}

///|
pub(all) struct Title {
  font : Font
  text : String
}

//Layout Props
///|
pub(all) struct Layout {}

//Trace Props
///|
pub(all) enum ScatterTraceMode {
  Markers
  Lines
  MarkersLines
}

///|
pub(all) enum TextPosition {
  TL
  TC
  TR
  ML
  MC
  MR
  BL
  BC
  BR
}

///|
pub(all) struct TraceScatter2D[U, V, N] {
  name : String
  mode : ScatterTraceMode
  x : Array[U]
  y : Array[V]
  text : Array[String]
  dx : N
  dy : N
  text_font : Font
  marker : Marker
  line : Line
}

//Chart Props
///|
pub(all) struct Chart {}
