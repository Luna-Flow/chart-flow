//Generic Props
///|
pub(all) enum Color {
  RGB(UInt, UInt, UInt)
  Hex(String) //"#XXXXXX"
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
  None
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
  DashLen(UInt)
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
  symbol : Array[Symbol]
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
pub(all) struct LayoutScatter {
  title : Title
  width : UInt
  height : UInt
  bg_color : Color
}

//Trace Props
///|
pub(all) enum TraceModeScatter {
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
  mode : TraceModeScatter
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
