//Generic Props
enum Color{
  RGB(UInt, UInt, UInt)
  RGBA(UInt, UInt, UInt, UInt)
  ColorDimension(Array[UInt])
}

//Font Props
enum FontStyle{
  Normal
  Italic
  Bold
}

enum LinePosition{
  Under
  Over
  Through
}

//Marker Props
enum Symbol{
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
enum Dash{
  Solid
  Dash
  Dot
  DashDot
  LongDash
  LongDashDot
}

enum Shape{
  Linear
  HV
  VH
  HVH
  VHV
}

//Basic Components
struct Marker{
  symbol: Symbol
  size: UInt
  color: Color
  color_scale: (Color, Color) //(lowest, highest)
  opacity: Float
}

struct Line{
  width: UInt
  dash: Dash
  shape: Shape
  color: Color
  opacity: Float
}
struct Font{
  line_pos: LinePosition
  family: String
  size: UInt
  color: Color
}

//Layout Props
struct Layout{

}

//Trace Props
