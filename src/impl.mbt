///|
impl ToJson for Color with to_json(s) {
  match s {
    Hex(x) => x.to_json()
    RGB(r, g, b) => "rgb(\{r},\{g},\{b})".to_json()
    ColorDimension(x) => x.to_json()
  }
}

///|
impl ToJson for FontStyle with to_json(s) {
  match s {
    Normal => "normal".to_json()
    Italic => "italic".to_json()
    Bold => "bold".to_json()
  }
}

///|
impl ToJson for LinePosition with to_json(s) {
  match s {
    None => "none".to_json()
    Under => "under".to_json()
    Over => "over".to_json()
    Through => "through".to_json()
  }
}

///|
impl ToJson for Symbol with to_json(s) {
  match s {
    Circle => "circle".to_json()
    Square => "square".to_json()
    Diamond => "diamond".to_json()
    Triangle => "triangle".to_json()
    Hexagon => "hexagon".to_json()
    Octagon => "octagon".to_json()
    Star => "star".to_json()
    Bowtie => "bowtie".to_json()
    Open => "open".to_json()
    X => "x".to_json()
    Cross => "cross".to_json()
    Dot => "dot".to_json()
  }
}

///|
impl ToJson for Dash with to_json(s) {
  match s {
    Solid => "solid".to_json()
    Dash => "dash".to_json()
    Dot => "dot".to_json()
    DashDot => "dashdot".to_json()
    LongDash => "longdash".to_json()
    LongDashDot => "longdashdot".to_json()
    DashLen(x) => (x.to_string() + "px").to_json()
  }
}

///|
impl ToJson for Shape with to_json(s) {
  match s {
    Linear => "linear".to_json()
    Spline => "spline".to_json()
    HV => "hv".to_json()
    VH => "vh".to_json()
    HVH => "hvh".to_json()
    VHV => "vhv".to_json()
  }
}

///|
fn compose_json(a : Json, b : Json, connector : String) -> Json {
  match a {
    String(a) =>
      match b {
        String(b) => String(a + connector + b)
        _ => abort("compose json accepts only strings")
      }
    _ => abort("compose json accepts only strings")
  }
}

///|
impl ToJson for Marker with to_json(s) {
  let obj : Map[String, Json] = Map::new()
  //need to impl Compose for Symbol, than do compose here
    ..set("symbol", s.symbol.to_json())
    ..set("size", s.size.to_json())
    ..set("color", s.color.to_json())
  if s.color is ColorDimension(_) {
    let color_min = s.color_scale.0.to_json()
    let color_max = s.color_scale.1.to_json()
    match color_min {
      String(_) =>
        match color_max {
          String(_) => obj.set("color_scale", Array([color_min, color_max]))
          _ => abort("color scale max must be a color code")
        }
      _ => abort("color scale min must be a color code")
    }
  }
  obj.set("opacity", s.opacity.to_json())
  Object(obj)
}
