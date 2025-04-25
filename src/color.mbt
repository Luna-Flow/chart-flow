///|
enum Color {
  Transparent
  RGB(UInt, UInt, UInt)
  RGBA(UInt, UInt, UInt, Double)
  HSV(UInt, Double, Double)
  HSL(UInt, Double, Double)
  CMYK(Double, Double, Double, Double)
}

///|
fn to_255(num : Double) -> UInt {
  (num * 255.0).to_uint()
}

///|
pub fn to_rgb(self : Color) -> Color {
  match self {
    Transparent => white
    RGB(_) => self
    RGBA(r, g, b, _) => RGB(r, g, b)
    HSV(h, s, v) => {
      let h_ = h.to_double() / 60.0
      let c = s * v
      let x = c * (1.0 - (h_ % 2.0 - 1.0).abs())
      let m = v - c
      let (r, g, b) = if h_ < 1.0 {
        (c, x, 0.0)
      } else if h_ < 2.0 {
        (x, c, 0.0)
      } else if h_ < 3.0 {
        (0.0, c, x)
      } else if h_ < 4.0 {
        (0.0, x, c)
      } else if h_ < 5.0 {
        (x, 0.0, c)
      } else {
        (c, 0.0, x)
      }
      RGB(to_255(r + m), to_255(g + m), to_255(b + m))
    }
    HSL(h, s, l) => {
      let h_ = h.to_double() / 60.0
      let c = (1.0 - (2.0 * l - 1.0).abs()) * s
      let x = c * (1.0 - (h_ % 2.0 - 1.0).abs())
      let m = l - c / 2.0
      let (r, g, b) = if h_ < 1.0 {
        (c, x, 0.0)
      } else if h_ < 2.0 {
        (x, c, 0.0)
      } else if h_ < 3.0 {
        (0.0, c, x)
      } else if h_ < 4.0 {
        (0.0, x, c)
      } else if h_ < 5.0 {
        (x, 0.0, c)
      } else {
        (c, 0.0, x)
      }
      RGB(to_255(r + m), to_255(g + m), to_255(b + m))
    }
    CMYK(c, m, y, k) => {
      let r = to_255((1.0 - c) * (1.0 - k))
      let g = to_255((1.0 - m) * (1.0 - k))
      let b = to_255((1.0 - y) * (1.0 - k))
      RGB(r, g, b)
    }
  }
}
