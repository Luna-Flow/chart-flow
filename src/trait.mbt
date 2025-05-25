///|
pub(open) trait Element: ToBlock {
  get_type(Self) -> String
}

///|
pub(open) trait Shape {
  tag(Self) -> String
}

///|
pub(open) trait Def {
  def_type(Self) -> String
}
