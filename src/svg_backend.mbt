///|
pub(open) trait ToHex {
  to_hex(Self) -> String
}

///|
fn alphabet(num : Int) -> String {
  match num {
    0 => "0"
    1 => "1"
    2 => "2"
    3 => "3"
    4 => "4"
    5 => "5"
    6 => "6"
    7 => "7"
    8 => "8"
    9 => "9"
    10 => "A"
    11 => "B"
    12 => "C"
    13 => "D"
    14 => "E"
    _ => "F"
  }
}

///|
pub impl ToHex for Byte with to_hex(self) {
  let i = self.to_int()
  let hi = alphabet(i / 16)
  let lo = alphabet(i % 16)
  hi + lo
}

///|
impl ToHex for RGBA with to_hex(self) {
  let r = self.r.to_hex()
  let g = self.g.to_hex()
  let b = self.b.to_hex()
  let a = self.a.to_hex()
  "#" + r + g + b + a
}

///|
test "color_cvt" {
  let c = RGBA::new(0, 255, 0, 255)
  assert_eq!(c.to_hex(), "#00FF00FF")
}

///|
impl Def for LinearGradient with id(self) {
  self.id
}

///|
impl Def for RadialGradient with id(self) {
  self.id
}

///|
pub(open) trait ToSVG {
  to_svg(Self, Double?) -> String
}

///|
fn to_zero_one(b : Bool) -> String {
  if b {
    "1"
  } else {
    "0"
  }
}

///|
pub impl ToSVG for PathCommand with to_svg(self, global) {
  let g = global.unwrap()
  match self {
    Move(p) => {
      let x = p.0.calc(g)
      let y = p.1.calc(g)
      "m \{x}, \{y}"
    }
    MoveTo(p) => {
      let x = p.0.calc(g)
      let y = p.1.calc(g)
      "M \{x}, \{y}"
    }
    Line(p) => {
      let x = p.0.calc(g)
      let y = p.1.calc(g)
      "l \{x}, \{y}"
    }
    LineTo(p) => {
      let x = p.0.calc(g)
      let y = p.1.calc(g)
      "L \{x}, \{y}"
    }
    Horizontal(s) => {
      let x = s.calc(g)
      "h \{x}"
    }
    HorizontalTo(s) => {
      let x = s.calc(g)
      "H \{x}"
    }
    Vertical(s) => {
      let y = s.calc(g)
      "v \{y}"
    }
    VerticalTo(s) => {
      let y = s.calc(g)
      "V \{y}"
    }
    Quadratic(p, p1) => {
      let x = p.0.calc(g)
      let y = p.1.calc(g)
      let x1 = p1.0.calc(g)
      let y1 = p1.1.calc(g)
      "q \{x}, \{y} \{x1}, \{y1}"
    }
    QuadraticTo(p, p1) => {
      let x = p.0.calc(g)
      let y = p.1.calc(g)
      let x1 = p1.0.calc(g)
      let y1 = p1.1.calc(g)
      "Q \{x}, \{y} \{x1}, \{y1}"
    }
    SmoothQuadratic(p) => {
      let x = p.0.calc(g)
      let y = p.1.calc(g)
      "t \{x}, \{y}"
    }
    SmoothQuadraticTo(p) => {
      let x = p.0.calc(g)
      let y = p.1.calc(g)
      "T \{x}, \{y}"
    }
    Cubic(p, p1, p2) => {
      let x = p.0.calc(g)
      let y = p.1.calc(g)
      let x1 = p1.0.calc(g)
      let y1 = p1.1.calc(g)
      let x2 = p2.0.calc(g)
      let y2 = p2.1.calc(g)
      "c \{x}, \{y} \{x1}, \{y1} \{x2}, \{y2}"
    }
    CubicTo(p, p1, p2) => {
      let x = p.0.calc(g)
      let y = p.1.calc(g)
      let x1 = p1.0.calc(g)
      let y1 = p1.1.calc(g)
      let x2 = p2.0.calc(g)
      let y2 = p2.1.calc(g)
      "C \{x}, \{y} \{x1}, \{y1} \{x2}, \{y2}"
    }
    SmoothCubic(p, p1) => {
      let x = p.0.calc(g)
      let y = p.1.calc(g)
      let x1 = p1.0.calc(g)
      let y1 = p1.1.calc(g)
      "s \{x}, \{y} \{x1}, \{y1}"
    }
    SmoothCubicTo(p, p1) => {
      let x = p.0.calc(g)
      let y = p.1.calc(g)
      let x1 = p1.0.calc(g)
      let y1 = p1.1.calc(g)
      "S \{x}, \{y} \{x1}, \{y1}"
    }
    Arc(r, rotation, large, sweep, p1) => {
      let rx = r.0.calc(g)
      let ry = r.1.calc(g)
      let large_str = to_zero_one(large)
      let sweep_str = to_zero_one(sweep)
      let x = p1.0.calc(g)
      let y = p1.1.calc(g)
      "a \{rx} \{ry} \{rotation} \{large_str} \{sweep_str} \{x} \{y}"
    }
    ArcTo(r, rotation, large, sweep, p1) => {
      let rx = r.0.calc(g)
      let ry = r.1.calc(g)
      let large_str = to_zero_one(large)
      let sweep_str = to_zero_one(sweep)
      let x = p1.0.calc(g)
      let y = p1.1.calc(g)
      "A \{rx} \{ry} \{rotation} \{large_str} \{sweep_str} \{x} \{y}"
    }
    Close => "Z"
  }
}

///|
pub impl ToSVG for Path with to_svg(self, global) {
  let str = loop self._, "" {
    Nil, path => break path
    Cons(command, rest), path =>
      continue rest, path + command.to_svg(global) + " "
  }
  let path = str.trim(" ").to_string()
  "d=\"\{path}\""
}

///|
pub impl ToSVG for GradientStop with to_svg(self, _) {
  let offset = self.0.get_pct()
  let color = self.1.to_hex()
  let opacity = self.2.to_string()
  "<stop offset=\"\{offset}\" stop-color=\"\{color}\" stop-opacity=\"\{opacity}\"/>"
}

///|
pub impl ToSVG for Paint with to_svg(self, _) {
  match self {
    Solid(c) => c.to_hex()
    Gradient(id) => "url(#\{id})"
  }
}

///|
fn attr_stk[T : Show](x : String) -> (T) -> String {
  fn { y => "stroke-\{x}=\"\{y}\" " }
}

///|
pub impl ToSVG for Stroke with to_svg(self, _) {
  let color = "stroke=\"\{self.color.to_svg(None)}\" "
  let mut dash_array = ""
  if self.dash_array.length() > 0 {
    dash_array = self.dash_array.map(Double::to_string).join(" ")
    dash_array = attr_stk("dasharray")(dash_array)
  }
  let dash_offset = self.dash_offset.map_or("", attr_stk("dashoffset"))
  let line_cap = self.line_cap.map_or("", attr_stk("linecap"))
  let line_join = self.line_join.map_or("", attr_stk("linejoin"))
  let miter_limit = self.miter_limit.map_or("", attr_stk("miterlimit"))
  let opacity = self.opacity.map_or("", attr_stk("opacity"))
  let width = self.width.map_or("", attr_stk("width"))
  "\{color}\{dash_array}\{dash_offset}\{line_cap}\{line_join}\{miter_limit}\{opacity}\{width}"
  .trim(" ")
  .to_string()
}

// ///|
// pub impl ToSVG for PathElement with to_svg(self, global) {
//   ...
// }
