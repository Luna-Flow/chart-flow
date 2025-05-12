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
pub(all) struct Polygon {
  points : List[Position]
}

///|
pub(all) struct Polyline {
  points : List[Position]
}
