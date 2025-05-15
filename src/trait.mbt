///|
pub(open) trait Element {}

///|
pub(open) trait Shape {
  to_path(Self) -> Path
}

///|
// pub(open) trait Def {
//   id(Self) -> String
// }

///|
pub(open) trait Style {
  to_style(Self) -> String
}
