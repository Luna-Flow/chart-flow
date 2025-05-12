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
pub(open) trait ToSVG {
  to_svg(Self, Double) -> String
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
  match self {
    Move(p) => {
      let x = p.0.calc(global)
      let y = p.1.calc(global)
      "m" + x.to_string() + ", " + y.to_string()
    }
    MoveTo(p) => {
      let x = p.0.calc(global)
      let y = p.1.calc(global)
      "M" + x.to_string() + ", " + y.to_string()
    }
    Line(p) => {
      let x = p.0.calc(global)
      let y = p.1.calc(global)
      "l" + x.to_string() + ", " + y.to_string()
    }
    LineTo(p) => {
      let x = p.0.calc(global)
      let y = p.1.calc(global)
      "L" + x.to_string() + ", " + y.to_string()
    }
    Horizontal(s) => {
      let x = s.calc(global)
      "h" + x.to_string()
    }
    HorizontalTo(s) => {
      let x = s.calc(global)
      "H" + x.to_string()
    }
    Vertical(s) => {
      let y = s.calc(global)
      "v" + y.to_string()
    }
    VerticalTo(s) => {
      let y = s.calc(global)
      "V" + y.to_string()
    }
    Quadratic(p, p1) => {
      let x = p.0.calc(global)
      let y = p.1.calc(global)
      let x1 = p1.0.calc(global)
      let y1 = p1.1.calc(global)
      "q" +
      x.to_string() +
      ", " +
      y.to_string() +
      " " +
      x1.to_string() +
      ", " +
      y1.to_string()
    }
    QuadraticTo(p, p1) => {
      let x = p.0.calc(global)
      let y = p.1.calc(global)
      let x1 = p1.0.calc(global)
      let y1 = p1.1.calc(global)
      "Q" +
      x.to_string() +
      ", " +
      y.to_string() +
      " " +
      x1.to_string() +
      ", " +
      y1.to_string()
    }
    SmoothQuadratic(p) => {
      let x = p.0.calc(global)
      let y = p.1.calc(global)
      "t" + x.to_string() + ", " + y.to_string()
    }
    SmoothQuadraticTo(p) => {
      let x = p.0.calc(global)
      let y = p.1.calc(global)
      "T" + x.to_string() + ", " + y.to_string()
    }
    Cubic(p, p1, p2) => {
      let x = p.0.calc(global)
      let y = p.1.calc(global)
      let x1 = p1.0.calc(global)
      let y1 = p1.1.calc(global)
      let x2 = p2.0.calc(global)
      let y2 = p2.1.calc(global)
      "c" +
      x.to_string() +
      ", " +
      y.to_string() +
      " " +
      x1.to_string() +
      ", " +
      y1.to_string() +
      " " +
      x2.to_string() +
      ", " +
      y2.to_string()
    }
    CubicTo(p, p1, p2) => {
      let x = p.0.calc(global)
      let y = p.1.calc(global)
      let x1 = p1.0.calc(global)
      let y1 = p1.1.calc(global)
      let x2 = p2.0.calc(global)
      let y2 = p2.1.calc(global)
      "C" +
      x.to_string() +
      ", " +
      y.to_string() +
      " " +
      x1.to_string() +
      ", " +
      y1.to_string() +
      " " +
      x2.to_string() +
      ", " +
      y2.to_string()
    }
    SmoothCubic(p, p1) => {
      let x = p.0.calc(global)
      let y = p.1.calc(global)
      let x1 = p1.0.calc(global)
      let y1 = p1.1.calc(global)
      "s" +
      x.to_string() +
      ", " +
      y.to_string() +
      " " +
      x1.to_string() +
      ", " +
      y1.to_string()
    }
    SmoothCubicTo(p, p1) => {
      let x = p.0.calc(global)
      let y = p.1.calc(global)
      let x1 = p1.0.calc(global)
      let y1 = p1.1.calc(global)
      "S" +
      x.to_string() +
      ", " +
      y.to_string() +
      " " +
      x1.to_string() +
      ", " +
      y1.to_string()
    }
    Arc(r, rotation, large, sweep, p1) => {
      let rx = r.0.calc(global)
      let ry = r.1.calc(global)
      let large_str = to_zero_one(large)
      let sweep_str = to_zero_one(sweep)
      let x = p1.0.calc(global)
      let y = p1.1.calc(global)
      "a" +
      rx.to_string() +
      " " +
      ry.to_string() +
      " " +
      rotation.to_string() +
      " " +
      large_str +
      " " +
      sweep_str +
      " " +
      x.to_string() +
      ", " +
      y.to_string()
    }
    ArcTo(r, rotation, large, sweep, p1) => {
      let rx = r.0.calc(global)
      let ry = r.1.calc(global)
      let large_str = to_zero_one(large)
      let sweep_str = to_zero_one(sweep)
      let x = p1.0.calc(global)
      let y = p1.1.calc(global)
      "A" +
      rx.to_string() +
      " " +
      ry.to_string() +
      " " +
      rotation.to_string() +
      " " +
      large_str +
      " " +
      sweep_str +
      " " +
      x.to_string() +
      ", " +
      y.to_string()
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
  str.trim(" ").to_string()
}

// ///|
// pub impl ToSVG for GradientStop with to_svg(self, global) {
//   ...
// }

// ///|
// pub impl ToSVG for PathElement with to_svg(self, global) {
//   ...
// }
