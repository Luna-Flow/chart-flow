///|
impl Style for ScatterStyle with apply_to(self, trace) {
  match trace {
    ScatterTrace(name, font, data, _) => ScatterTrace(name, font, data, self)
    LineTrace(_) => abort("ScatterStyle cannot be applied to LineTrace")
    BarTrace(_) => abort("ScatterStyle cannot be applied to BarTrace")
  }
}

///|
impl Style for ScatterStyle with with_color(self, color) {
  match self {
    ScatterStyle(s_type, _) => ScatterStyle(s_type, color)
  }
}

///|
impl Style for ScatterStyle with with_size(self, size) {
  match self {
    ScatterStyle(s_type, color) => ScatterStyle(s_type.with_size(size), color)
  }
}

///|
impl Style for LineStyle with apply_to(self, trace) {
  match trace {
    ScatterTrace(_) => abort("LineStyle cannot be applied to ScatterTrace")
    LineTrace(name, font, data, _) => LineTrace(name, font, data, self)
    BarTrace(_) => abort("LineStyle cannot be applied to BarTrace")
  }
}

///|
impl Style for LineStyle with with_color(self, color) {
  match self {
    LineStyle(l_type, _) => LineStyle(l_type, color)
    LineStyleWithMarker(l_style, s_type) =>
      match l_style {
        LineStyle(l_type, _) =>
          LineStyleWithMarker(LineStyle(l_type, color), s_type)
        _ => abort("Nested LineStyleWithMarker is invalid")
      }
  }
}

///|
impl Style for LineStyle with with_size(self, size) {
  match self {
    LineStyle(l_type, color) => LineStyle(l_type.with_size(size), color)
    LineStyleWithMarker(l_style, s_type) =>
      match l_style {
        LineStyle(l_type, color) =>
          LineStyleWithMarker(LineStyle(l_type.with_size(size), color), s_type)
        _ => abort("Nested LineStyleWithMarker is invalid")
      }
  }
}

///|
impl Style for BarStyle with apply_to(self, trace) {
  match trace {
    ScatterTrace(_) => abort("BarStyle cannot be applied to ScatterTrace")
    LineTrace(_) => abort("BarStyle cannot be applied to LineTrace")
    BarTrace(name, font, data, _) => BarTrace(name, font, data, self)
  }
}

///|
impl Style for BarStyle with with_color(self, color) {
  match self {
    BarStyle(stroke_width, _, fill) => BarStyle(stroke_width, color, fill)
  }
}

///|
impl Style for BarStyle with with_size(self, size) {
  match self {
    BarStyle(_, fill, stroke) => BarStyle(size, fill, stroke)
  }
}

///|
impl Style for TextStyle with apply_to(self, trace) {
  match trace {
    ScatterTrace(name, font, data, style) =>
      if font is None {
        ScatterTrace(name, Some(self), data, style)
      } else {
        ScatterTrace(name, font, data, style)
      }
    LineTrace(name, font, data, style) =>
      if font is None {
        LineTrace(name, Some(self), data, style)
      } else {
        LineTrace(name, font, data, style)
      }
    BarTrace(name, font, data, style) =>
      if font is None {
        BarTrace(name, Some(self), data, style)
      } else {
        BarTrace(name, font, data, style)
      }
  }
}

///|
impl Style for TextStyle with with_color(self, color) {
  match self {
    TextStyle(size, font, _) => TextStyle(size, font, color)
  }
}

///|
impl Style for TextStyle with with_size(self, size) {
  match self {
    TextStyle(_, font, color) => TextStyle(size, font, color)
  }
}

///|
impl Size for ScatterType with with_size(self, size) {
  match self {
    Circle(_) => Circle(size)
    Square(_) => Square(size)
    Triangle(_) => Triangle(size)
    Diamond(_) => Diamond(size)
    Cross(_) => Cross(size)
    X(_) => X(size)
    Star(_) => Star(size)
  }
}

///|
impl Size for LineType with with_size(self, size) {
  match self {
    Solid(_) => Solid(size)
    Dot(_, gap) => Dot(size, gap)
    Dash(_, length, gap) => Dash(size, length, gap)
  }
}
