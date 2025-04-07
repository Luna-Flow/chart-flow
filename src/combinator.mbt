///|
pub fn with_data(self : Trace, data : Array[Point2D]) -> Trace {
  match self {
    Trace::LineTrace(name, font_opt, _, style) =>
      Trace::LineTrace(name, font_opt, data, style)
    Trace::ScatterTrace(name, font_opt, _, style) =>
      Trace::ScatterTrace(name, font_opt, data, style)
    Trace::BarTrace(name, font_opt, _, style) =>
      Trace::BarTrace(name, font_opt, data, style)
  }
}

///|
pub fn with_color(self : Trace, color : Color) -> Trace {
  match self {
    Trace::LineTrace(name, font_opt, data, style) =>
      Trace::LineTrace(name, font_opt, data, style.with_color(color))
    Trace::ScatterTrace(name, font_opt, data, style) =>
      Trace::ScatterTrace(name, font_opt, data, style.with_color(color))
    Trace::BarTrace(name, font_opt, data, style) =>
      Trace::BarTrace(name, font_opt, data, style.with_color(color))
  }
}

///|
pub fn empty_line_trace() -> Trace {
  Trace::LineTrace("", None, [], dft_line_style)
}

///|
pub fn line_trace(
  data : Array[Point2D],
  style~ : LineStyle = dft_line_style
) -> Trace {
  Trace::LineTrace("Line", None, data, style)
}

///|
pub fn empty_chart() -> Chart {
  Chart::{ title: None, trace: [], x_axis: None, y_axis: None }
}
