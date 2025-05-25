///|
pub(all) struct Circle {
  center_x : Size
  center_y : Size
  radius : Size
}

///|
impl Shape for Circle with tag(_) -> String {
  "circle"
}

///|
pub(all) struct Ellipse {
  center_x : Size
  center_y : Size
  radius_x : Size
  radius_y : Size
}

///|
impl Shape for Ellipse with tag(_) -> String {
  "ellipse"
}

///|
pub(all) struct Rect {
  x : Size
  y : Size
  width : Size
  height : Size
  rx : Size?
  ry : Size?
}

///|
impl Shape for Rect with tag(_) -> String {
  "rect"
}

///|
pub(all) struct Line {
  x1 : Size
  y1 : Size
  x2 : Size
  y2 : Size
}

///|
impl Shape for Line with tag(_) -> String {
  "line"
}

///|
/// need calc size while converting to path & svg
pub(all) struct Polygon {
  points : Array[Position]
}

///|
impl Shape for Polygon with tag(_) -> String {
  "polygon"
}

///|
/// need calc size while converting to path & svg
pub(all) struct Polyline {
  points : Array[Position]
}

///|
impl Shape for Polyline with tag(_) -> String {
  "polyline"
}
