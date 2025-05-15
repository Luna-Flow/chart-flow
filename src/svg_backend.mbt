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
type BlockAttr HashMap[String, String]

///|
struct Block[T] {
  tag : String
  attr : BlockAttr
  content : Array[T]
}

///|
typealias BasicBlock = Block[Unit]

///|
typealias TextBlock = Block[String]

///|
typealias ContentBlock[T] = Block[T]

///|
trait Any {}

///|
pub(open) trait ToAttr {
  to_attr(Self, Double?) -> Array[(String, String)]
}

///|
pub(open) trait ToBlock {
  to_block(Self, Double?) -> Block[&Any]
}

///|
pub(open) trait ToSVG {
  to_svg(Self) -> String
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
fn pmap[T](self : Position, f : (Size) -> T) -> (T, T) {
  (f(self.0), f(self.1))
}

///|
fn gcalc(g : Double) -> (Size) -> Double {
  fn { y => y.calc(g) }
}

///|
fn PathCommand::to_string(self : PathCommand, g : Double) -> String {
  match self {
    Move(p) => {
      let (x, y) = p.pmap(gcalc(g))
      "m \{x}, \{y}"
    }
    MoveTo(p) => {
      let (x, y) = p.pmap(gcalc(g))
      "M \{x}, \{y}"
    }
    Line(p) => {
      let (x, y) = p.pmap(gcalc(g))
      "l \{x}, \{y}"
    }
    LineTo(p) => {
      let (x, y) = p.pmap(gcalc(g))
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
      let (x, y) = p.pmap(gcalc(g))
      let (x1, y1) = p1.pmap(gcalc(g))
      "q \{x}, \{y} \{x1}, \{y1}"
    }
    QuadraticTo(p, p1) => {
      let (x, y) = p.pmap(gcalc(g))
      let (x1, y1) = p1.pmap(gcalc(g))
      "Q \{x}, \{y} \{x1}, \{y1}"
    }
    SmoothQuadratic(p) => {
      let (x, y) = p.pmap(gcalc(g))
      "t \{x}, \{y}"
    }
    SmoothQuadraticTo(p) => {
      let (x, y) = p.pmap(gcalc(g))
      "T \{x}, \{y}"
    }
    Cubic(p, p1, p2) => {
      let (x, y) = p.pmap(gcalc(g))
      let (x1, y1) = p1.pmap(gcalc(g))
      let (x2, y2) = p2.pmap(gcalc(g))
      "c \{x}, \{y} \{x1}, \{y1} \{x2}, \{y2}"
    }
    CubicTo(p, p1, p2) => {
      let (x, y) = p.pmap(gcalc(g))
      let (x1, y1) = p1.pmap(gcalc(g))
      let (x2, y2) = p2.pmap(gcalc(g))
      "C \{x}, \{y} \{x1}, \{y1} \{x2}, \{y2}"
    }
    SmoothCubic(p, p1) => {
      let (x, y) = p.pmap(gcalc(g))
      let (x1, y1) = p1.pmap(gcalc(g))
      "s \{x}, \{y} \{x1}, \{y1}"
    }
    SmoothCubicTo(p, p1) => {
      let (x, y) = p.pmap(gcalc(g))
      let (x1, y1) = p1.pmap(gcalc(g))
      "S \{x}, \{y} \{x1}, \{y1}"
    }
    Arc(r, rotation, large, sweep, p1) => {
      let (rx, ry) = r.pmap(gcalc(g))
      let large_str = to_zero_one(large)
      let sweep_str = to_zero_one(sweep)
      let (x, y) = p1.pmap(gcalc(g))
      "a \{rx} \{ry} \{rotation} \{large_str} \{sweep_str} \{x} \{y}"
    }
    ArcTo(r, rotation, large, sweep, p1) => {
      let (rx, ry) = r.pmap(gcalc(g))
      let large_str = to_zero_one(large)
      let sweep_str = to_zero_one(sweep)
      let (x, y) = p1.pmap(gcalc(g))
      "A \{rx} \{ry} \{rotation} \{large_str} \{sweep_str} \{x} \{y}"
    }
    Close => "Z"
  }
}

///|
pub impl ToAttr for Path with to_attr(self, g) {
  let str = loop self._, "" {
    Nil, path => break path
    Cons(command, rest), path =>
      continue rest, path + command.to_string(g.unwrap()) + " "
  }
  let path = str.trim(" ").to_string()
  [("d", "\"\{path}\"")]
}

///|
fn TransformCommand::to_string(self : TransformCommand, g : Double) -> String {
  let mut op = ""
  let mut para = ""
  match self {
    Matrix(a, b, c, d, e, f) => {
      op = "matrix"
      para = "\{a} \{b} \{c} \{d} \{e} \{f}"
    }
    Translate(p) => {
      let (x, y) = p.pmap(gcalc(g))
      op = "translate"
      para = "\{x} \{y}"
    }
    Scale(x, y) => {
      op = "scale"
      para = "\{x}, \{y}"
    }
    Rotate(angle, pos) => {
      op = "rotate"
      let opt_pos = pos.map_or("", fn {
        p => ", \{p.0.calc(g)}, \{p.1.calc(g)}"
      })
      para = "\{angle}\{opt_pos}"
    }
    SkewX(angle) => {
      op = "skewX"
      para = "\{angle}"
    }
    SkewY(angle) => {
      op = "skewY"
      para = "\{angle}"
    }
  }
  "\{op}(\{para})"
}

///|
impl ToAttr for Transform with to_attr(self, g) {
  let str = loop self._, "" {
    Nil, trans => break trans
    Cons(op, rest), trans =>
      continue rest, trans + op.to_string(g.unwrap()) + " "
  }
  let trans = str.trim(" ").to_string()
  [("transform", "\"\{trans}\"")]
}

///|
pub impl ToBlock for GradientStop with to_block(self, _) {
  let attrs = []
  attrs.push(("offset", self.0.get_pct()))
  attrs.push(("stop-color", self.1.to_hex()))
  let opacity = self.2.map_or("", fn { x => x.to_string() })
  if opacity != "" {
    attrs.push(("stop-opacity", opacity))
  }
  BasicBlock::{ tag: "stop", attr: @hashmap.from_array(attrs), content: [] }
}

///|
pub fn Paint::to_string(self : Paint) -> String {
  match self {
    Solid(c) => c.to_hex()
    Gradient(id) => "url(#\{id})"
  }
}

///|
fn attr[T : Show](x : String) -> (String) -> (T) -> (String, String) {
  fn { y => fn { z => ("\{x}-\{y}", "\"\{z}\"") } }
}

///|
fn attr_stk[T : Show](x : String) -> (T) -> (String, String) {
  attr("stroke")(x)
}

///|
pub impl ToAttr for Stroke with to_attr(self, _) {
  let attr = []
  attr.push(("stroke", self.color.to_string()))
  if self.dash_array.length() > 0 {
    attr.push(
      ("stroke-dasharray", self.dash_array.map(Double::to_string).join(" ")),
    )
  }
  if self.dash_offset is Some(x) {
    attr.push(attr_stk("dashoffset")(x))
  }
  if self.line_cap is Some(x) {
    attr.push(attr_stk("linecap")(x))
  }
  if self.line_join is Some(x) {
    attr.push(attr_stk("linejoin")(x))
  }
  if self.miter_limit is Some(x) {
    attr.push(attr_stk("miterlimit")(x))
  }
  if self.opacity is Some(x) {
    attr.push(attr_stk("opacity")(x))
  }
  if self.width is Some(x) {
    attr.push(attr_stk("width")(x))
  }
  attr
}

///|
fn attr_fill[T : Show](x : String) -> (T) -> (String, String) {
  attr("fill")(x)
}

///|
pub impl ToAttr for Fill with to_attr(self, _) {
  let attr = []
  attr.push(("fill", self.color.to_string()))
  if self.opacity is Some(x) {
    attr.push(attr_fill("opacity")(x))
  }
  if self.rule is Some(x) {
    attr.push(attr_fill("rule")(x))
  }
  attr
}

///|
pub impl ToBlock for PathElement with to_block(self, g) {
  let attr = []
  attr.push_iter(self.path.to_attr(g).iter())
  if self.fill is Some(x) {
    attr.push_iter(x.to_attr(g).iter())
  }
  if self.stroke is Some(x) {
    attr.push_iter(x.to_attr(g).iter())
  }
  if self.transform is Some(x) {
    attr.push_iter(x.to_attr(g).iter())
  }
  BasicBlock::{ tag: "path", attr: @hashmap.from_array(attr), content: [] }
}
