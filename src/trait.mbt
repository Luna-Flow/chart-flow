///|
pub(open) trait Element {}

///|
pub(open) trait Shape {
  to_path(Self) -> Path
}
