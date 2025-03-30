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
    Bold(bold) => bold.to_json()
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
const SYM_CATE_SHAPE = "shape"

///|
const SYM_CATE_STYLE = "style"

///|
impl Category for Symbol with get_cate(s) {
  match s {
    Circle => SYM_CATE_SHAPE
    Square => SYM_CATE_SHAPE
    Diamond => SYM_CATE_SHAPE
    Triangle => SYM_CATE_SHAPE
    Hexagon => SYM_CATE_SHAPE
    Octagon => SYM_CATE_SHAPE
    Star => SYM_CATE_SHAPE
    Bowtie => SYM_CATE_SHAPE
    Cross => SYM_CATE_SHAPE
    X => SYM_CATE_SHAPE
    Open => SYM_CATE_STYLE
  }
}

///|
impl Compose for Symbol with compose(arr) {
  let len = arr.length()
  if len == 0 {
    abort("symbol array must have at least one element")
  } else if len == 1 {
    arr[0].to_json()
  } else if len == 2 {
    compose_json(arr[0].to_json(), arr[1].to_json(), "-")
  } else {
    abort("symbol array must have at most three elements")
  }
}

///|
impl Compose for Symbol with is_valid(arr) {
  let len = arr.length()
  if len == 1 && arr[0].get_cate() == SYM_CATE_SHAPE {
    true
  } else if len == 2 &&
    arr[0].get_cate() == SYM_CATE_SHAPE &&
    arr[1].get_cate() == SYM_CATE_STYLE {
    true
  } else {
    false
  }
}

///|
impl ToJson for Marker with to_json(s) {
  let obj : Map[String, Json] = Map::new()
  if s.size is Some(_) {
    obj.set("size", s.size.unwrap().to_json())
  }
  if s.color is Some(_) {
    obj.set("color", s.color.unwrap().to_json())
    if s.color is Some(ColorDimension(_)) {
      let color_min = s.color_scale.unwrap().0.to_json()
      let color_max = s.color_scale.unwrap().1.to_json()
      match color_min {
        String(_) =>
          match color_max {
            String(_) => obj.set("color_scale", Array([color_min, color_max]))
            _ => abort("color scale max must be a color code")
          }
        _ => abort("color scale min must be a color code")
      }
    }
  }
  if s.opacity is Some(_) {
    obj.set("opacity", s.opacity.unwrap().to_json())
  }
  if s.symbol is Some(_) {
    if Compose::is_valid(s.symbol.unwrap()) {
      obj.set("symbol", s.symbol.unwrap().to_json())
    } else {
      abort("Invalid symbol component.")
    }
  }
  Object(obj)
}

///|
impl ToJson for Line with to_json(s) {
  let obj : Map[String, Json] = Map::new()
  if s.width is Some(_) {
    obj.set("width", s.width.unwrap().to_json())
  }
  if s.dash is Some(_) {
    obj.set("dash", s.dash.unwrap().to_json())
  }
  if s.shape is Some(_) {
    obj.set("shape", s.shape.unwrap().to_json())
    if s.smoothing is Some(_) {
      obj.set("smoothing", clamp(s.smoothing.unwrap(), 0, 1.3).to_json())
    }
  }
  if s.color is Some(_) {
    match s.color.unwrap() {
      ColorDimension(_) => abort("cannot use color dimension in line")
      _ => obj.set("color", s.color.unwrap().to_json())
    }
  }
  if s.opacity is Some(_) {
    obj.set("opacity", s.opacity.unwrap().to_json())
  }
  Object(obj)
}

///|
const LP_CATE_NONE = "none"

///|
const LP_CATE_STYLE = "style"

///|
impl Category for LinePosition with get_cate(s) {
  match s {
    Over => LP_CATE_STYLE
    Under => LP_CATE_STYLE
    None => LP_CATE_NONE
    Through => LP_CATE_STYLE
  }
}

///|
impl Compose for LinePosition with compose(arr) {
  let len = arr.length()
  if len == 0 {
    abort("symbol array must have at least one element")
  } else if len == 1 {
    arr[0].to_json()
  } else if len == 2 {
    compose_json(arr[0].to_json(), arr[1].to_json(), "+")
  } else {
    abort("symbol array must have at most three elements")
  }
}

///|
impl Compose for LinePosition with is_valid(arr) {
  let len = arr.length()
  let cate_map = []
  for x in arr {
    cate_map.push(Category::get_cate(x))
  }
  if len == 1 {
    true
  } else if len == 2 && same_to(cate_map, LP_CATE_STYLE) {
    true
  } else if len == 3 && same_to(cate_map, LP_CATE_STYLE) {
    true
  } else {
    false
  }
}

///|
impl ToJson for Font with to_json(s) {
  let obj : Map[String, Json] = Map::new()
  if s.family is Some(_) {
    obj.set("family", s.family.unwrap().to_json())
  }
  if s.size is Some(_) {
    obj.set("size", s.size.unwrap().to_json())
  }
  if s.color is Some(_) {
    obj.set("color", s.color.unwrap().to_json())
    match s.color.unwrap() {
      ColorDimension(_) => abort("cannot use color dimension in font")
      _ => obj.set("color", s.color.unwrap().to_json())
    }
  }
  if s.line_pos is Some(_) {
    if Compose::is_valid(s.line_pos.unwrap()) {
      obj.set("lineposition", Compose::compose(s.line_pos.unwrap()))
    } else {
      abort("Invalid lineposition component")
    }
  } else {
    abort("Invalid lineposition component")
  }
  if s.style is Some(_) {
    match s.style.unwrap() {
      Bold(_) => abort("Invalid style component")
      _ => obj.set("style", s.style.unwrap().to_json())
    }
  }
  if s.weight is Some(_) {
    match s.weight.unwrap() {
      Bold(_) => obj.set("weight", s.weight.unwrap().to_json())
      _ => abort("Invalid weight component")
    }
  }
  Object(obj)
}
