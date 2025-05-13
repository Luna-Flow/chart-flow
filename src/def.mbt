///|
pub(all) type GradientStop (Size, RGBA, Double)

///|
pub(all) struct LinearGradient {
  id : String
  start : (Double, Double)?
  end : (Double, Double)?
  transform : List[Transform]
  stops : Array[GradientStop]
}

///|
pub(all) struct RadialGradient {
  id : String
  coordinate : (Double, Double)?
  gradient_stops : Array[GradientStop]
}
