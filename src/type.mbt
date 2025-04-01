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
  Bold(Int)
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
  symbol : Array[Symbol]?
  size : UInt?
  color : Color?
  color_scale : (Color, Color)? //(lowest, highest)
  opacity : Float?
}

///|
pub(all) struct Line {
  width : UInt?
  dash : Dash?
  shape : Shape?
  smoothing : Float? //[0, 1.3]
  color : Color?
  opacity : Float?
}

///|
pub(all) struct Font {
  line_pos : Array[LinePosition]?
  family : String?
  size : UInt?
  color : Color?
  style : FontStyle?
  weight : FontStyle?
}

///|
pub(all) struct Title {
  font : Font?
  text : String
}

//Layout Props
///|
pub(all) struct LayoutScatter {
  title : Title?
  width : UInt?
  height : UInt?
  bg_color : Color?
}

//Trace Props
///|
pub(all) enum TraceModeScatter {
  Markers
  Lines
  MarkersLines
}

///|
pub(all) enum Position {
  Top
  Middle
  Bottom
  Left
  Center
  Right
}

///|
pub(all) struct TraceScatter2D[U, V, N] {
  name : String
  mode : TraceModeScatter
  x : Array[U]
  y : Array[V]
  text : Array[String]?
  dx : N?
  dy : N?
  text_font : Font?
  text_position : (Position, Position)?
  marker : Marker?
  line : Line?
}

//Chart Props
///|
pub(all) struct ChartScatter2D[U, V, N] {
  name : String
  traces : Array[TraceScatter2D[U, V, N]]
  layout : LayoutScatter?
}

///|
pub(all) enum Categories {
  SYM_CATE_SHAPE
  SYM_CATE_STYLE
  LP_CATE_NONE
  LP_CATE_STYLE
  POS_CATE_VERTICAL
  POS_CATE_HORIZONTAL
} derive(Eq)
