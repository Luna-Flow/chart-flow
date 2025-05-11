///|
pub(all) struct Circle[T] {
  center_x : T
  center_y : T
  radius : T
}

///|
pub(all) struct Ellipse[T] {
  center_x : T
  center_y : T
  radius_x : T
  radius_y : T
}

///|
pub(all) struct Line[T] {
  x1 : T
  y1 : T
  x2 : T
  y2 : T
}

///|
pub(all) struct Polygon {
  points : List[Position]
}

///|
pub(all) struct Polyline {
  points : List[Position]
}
