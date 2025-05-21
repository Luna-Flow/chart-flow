///|
pub(all) type GradientStop (Size, RGBA, Double?)

///|
pub(all) enum GradientSpreadMethod {
  Pad
  Reflect
  Repeat
}

///|
pub impl Show for GradientSpreadMethod with to_string(self) -> String {
  match self {
    Pad => "pad"
    Reflect => "reflect"
    Repeat => "repeat"
  }
}

///|
pub impl Show for GradientSpreadMethod with output(self, l) {
  l.write_string(self.to_string())
}

///|
pub(all) struct LinearGradient {
  id : String
  start : (Double, Double)?
  end : (Double, Double)?
  transform : Transform?
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
