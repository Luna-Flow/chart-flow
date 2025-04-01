///|
pub(open) trait Compose {
  compose(Array[Self]) -> Json
  is_valid(Array[Self]) -> Bool
}

///|
pub(open) trait Category {
  get_cate(Self) -> Categories
}
