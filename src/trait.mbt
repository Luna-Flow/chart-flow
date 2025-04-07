///|
pub(open) trait Style {
  apply_to(Self, Trace) -> Trace
  with_color(Self, Color) -> Self
  with_size(Self, UInt) -> Self
}

///|
pub(open) trait Size {
  with_size(Self, UInt) -> Self
}
