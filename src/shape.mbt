///|
pub(all) struct Circle {
  center_x : Size
  center_y : Size
  radius : Size
}

///|
pub(all) struct Ellipse {
  center_x : Size
  center_y : Size
  radius_x : Size
  radius_y : Size
}

///|
pub(all) struct Line {
  x1 : Size
  y1 : Size
  x2 : Size
  y2 : Size
}

///|
/// need calc size while converting to path & svg
pub(all) struct Polygon {
  points : Array[Position]
}

///|
/// need calc size while converting to path & svg
pub(all) struct Polyline {
  points : Array[Position]
}
