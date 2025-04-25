///|
pub fn normalize_data(
  f : (Double) -> Double,
  raw : Array[Double]
) -> Array[Double] {
  raw.map(f)
}

///|
pub fn min_max_scale(raw : Array[Double]) -> Array[Double] {
  let min = raw.iter().minimum().unwrap()
  let max = raw.iter().maximum().unwrap()
  normalize_data(fn(x) { (x - min) / (max - min) }, raw)
}
