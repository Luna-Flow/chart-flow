///|
pub(all) type GradientStop (Size, RGBA, Double?)

///|
pub(all) enum GradientSpreadMethod {
  Pad
  Reflect
  Repeat
}

///|
pub(all) struct LinearGradient {
  id : String
  start : (Double, Double)?
  end : (Double, Double)?
  transform : Transform
  stops : Array[GradientStop]
  spread : GradientSpreadMethod?
}

///|
pub(all) struct RadialGradient {
  id : String
  coordinate : (Double, Double)?
  start : (Double, Double)?
  radius : Double?
  stops : Array[GradientStop]
  spread : GradientSpreadMethod?
}
