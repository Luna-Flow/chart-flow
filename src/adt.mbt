///|
pub(all) type Position (Double, Double)

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
  Horizontal(Double)
  //HorizontalTo(x)
  HorizontalTo(Position)
  //Vertical(dy)
  Vertical(Double)
  //VerticalTo(y)
  VerticalTo(Position)
  //Quadratic(dx1, dy1, dx, dy)
  Quadratic(Position, Position)
  //QuadraticTo(x1, y1, x, y)
  QuadraticTo(Position, Position)
  //SmoothQuadratic(dx, dy)
  SmoothQuadratic(Position)
  //SmoothQuadraticTo(x, y)
  SmoothQuadraticTo(Position)
  //Cubic(dx1, dy1, dx2, dy2, dx, dy)
  Cubic(Position, Position, Position)
  //CubicTo(x1, y1, x2, y2, x, y)
  CubicTo(Position, Position, Position)
  //SmoothCubic(dx2, dy2, dx, dy)
  SmoothCubic(Position)
  //SmoothCubicTo(x2, y2, x, y)
  SmoothCubicTo(Position)
  //Arc(rx, ry, xAxisRotation<deg>, largeArcFlag, sweepFlag, dx, dy)
  Arc(Double, Double, Double, Bool, Bool, Position)
  //ArcTo(rx, ry, xAxisRotation<deg>, largeArcFlag, sweepFlag, x, y)
  ArcTo(Double, Double, Double, Bool, Bool, Position)
  Close
}

///|
pub(all) enum GradientType {
  Linear
  Radial
}

///|
pub(all) type GradientStop (&Color, Double)

///|
pub(all) enum Paint {
  Solid(&Color)
  //Gradient(GradientType, start_color, start, end_color, end, gradient_stops)
  Gradient(
    GradientType,
    &Color,
    Position,
    &Color,
    Position,
    Array[GradientStop]
  )
}

///|
pub(all) type Path Array[PathCommand]

///|
pub(all) struct Stroke {
  width : Double
  color : Paint
}

///|
pub(all) struct Fill {
  color : Paint
}
