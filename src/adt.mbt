///|
struct Size {
  num : Double
  pct : Double
  parent : Size?
} derive(Eq)

///|
pub(all) type Position (Size, Size)

///|
pub(all) enum PathCommand {
  //Move(dx, dy)
  Move(Position)
  //MoveTo(x, y)
  MoveTo(Position)
  //Line(dx, dy)
  Line(Position)
  //LineTo(x, y)
  LineTo(Position)
  //Horizontal(dx)
  Horizontal(Size)
  //HorizontalTo(x)
  HorizontalTo(Size)
  //Vertical(dy)
  Vertical(Size)
  //VerticalTo(y)
  VerticalTo(Size)
  //Quadratic(dx1, dy1, dx, dy)
  Quadratic(Position, Position)
  //QuadraticTo(x1, y1, x, y)
  QuadraticTo(Position, Position)
  //SmoothQuadratic(dx, dy)
  SmoothQuadratic(Position)
  //SmoothQuadraticTo(x, y)
  SmoothQuadraticTo(Position)
  //Cubic((dx1, dy1), (dx2, dy2), (dx, dy))
  Cubic(Position, Position, Position)
  //CubicTo((x1, y1), (x2, y2), (x, y))
  CubicTo(Position, Position, Position)
  //SmoothCubic((dx2, dy2), (dx, dy))
  SmoothCubic(Position, Position)
  //SmoothCubicTo((x2, y2), (x, y))
  SmoothCubicTo(Position, Position)
  //Arc((rx, ry), xAxisRotation<deg>, largeArcFlag, sweepFlag, (dx, dy))
  Arc(Position, Double, Bool, Bool, Position)
  //ArcTo((rx, ry), xAxisRotation<deg>, largeArcFlag, sweepFlag, (x, y))
  ArcTo(Position, Double, Bool, Bool, Position)
  Close
}

///|

///|
pub(all) enum Paint {
  // Solid(color)
  Solid(RGBA)
  // Gradient(id)
  Gradient(String)
}

///|
pub(all) type Path List[PathCommand]

///|
pub(all) enum LineCap {
  Butt
  Round
  Square
}

///|
pub(all) enum LineJoin {
  Arcs
  Bevel
  Miter
  MiterClip
  Round
}

///|
pub(all) struct Stroke {
  color : Paint
  dash_array : Array[Double]
  dash_offset : Double?
  line_cap : LineCap?
  line_join : LineJoin?
  miter_limit : Double?
  opacity : Double?
  width : Double?
}

///|
pub(all) enum FillRule {
  NonZero
  EvenOdd
}

///|
pub(all) struct Fill {
  color : Paint
  opacity : Double?
  rule : FillRule?
}

///|
pub(all) enum TransformCommand {
  Matrix(Double, Double, Double, Double, Double, Double)
  Translate(Position)
  Scale(Double, Double)
  Rotate(Double, Position?)
  SkewX(Double)
  SkewY(Double)
}

///|
pub(all) type Transform List[TransformCommand]

///|
pub(all) struct PathElement {
  path : Path
  fill : Fill?
  stroke : Stroke?
  transform : Transform?
}

///|
pub(all) struct TextElement {
  content : String
  position : Position
  offset : Position?
  rotate : Double?
  font_family : String
  font_size : Double
  text_anchor : TextAnchor
  fill : Fill?
  stroke : Stroke?
  transform : Transform
}

///|
pub(all) enum TextAnchor {
  Start
  Middle
  End
}

///|
pub(all) struct ImageElement {
  href : String
  width : Double
  height : Double
  position : Position
  transform : Transform
}

///|
pub(all) struct ShapeElement[S] {
  anchor : Position
  shape : S
  fill : Fill?
  stroke : Stroke?
}

///|
pub(all) struct Layer {
  elements : Array[&Element]
  index : Int
  name : String
  visible : Bool
  opacity : Double
}
