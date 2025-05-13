///|
pub fn Path::from_array(arr : Array[PathCommand]) -> Path {
  @immut/list.from_array(arr)
}

///|
pub fn Size::same_parent(self : Size, other : Size) -> Bool {
  if self.parent == other.parent {
    true
  } else {
    false
  }
}

///|
pub fn Size::calc(self : Size, global : Double) -> Double {
  if self.parent is None {
    if self.pct == 0.0 {
      self.num
    } else {
      self.num + self.pct * global / 100.0
    }
  } else if self.pct == 0.0 {
    self.num + self.parent.unwrap().calc(global)
  } else {
    self.num + self.pct * self.parent.unwrap().calc(global) / 100.0
  }
}

///|
fn Size::calc_keep_pct_aux(self : Size) -> (Double, Double) {
  if self.parent is None {
    (self.num, self.pct)
  } else {
    (
      self.num + self.parent.unwrap().calc_keep_pct_aux().0 * self.pct / 100.0,
      self.parent.unwrap().calc_keep_pct_aux().1 * self.pct / 100.0,
    )
  }
}

///|
pub fn Size::calc_keep_pct(self : Size) -> Size {
  if self.parent is None {
    Size::{ num: self.num, pct: self.pct, parent: None }
  } else {
    let (num_calc, pct_calc) = self.calc_keep_pct_aux()
    Size::{ num: num_calc, pct: pct_calc, parent: None }
  }
}

///|
fn Size::get_pct(self : Size) -> String {
  self.pct.to_string() + "%"
}

///|
pub impl Add for Size with op_add(self, other) {
  if self.same_parent(other) {
    Size::{
      num: self.num + other.num,
      pct: self.pct + other.pct,
      parent: self.parent,
    }
  } else {
    abort("Cannot add sizes with different parents")
  }
}

///|
pub impl Show for LineCap with to_string(self) {
  match self {
    Butt => "butt"
    Round => "round"
    Square => "square"
  }
}

///|
pub impl Show for LineCap with output(self, l) {
  l.write_string(self.to_string())
}

///|
pub impl Show for LineJoin with to_string(self) {
  match self {
    Bevel => "bevel"
    Arcs => "arcs"
    Miter => "miter"
    MiterClip => "miter-clip"
    Round => "round"
  }
}

///|
pub impl Show for LineJoin with output(self, l) {
  l.write_string(self.to_string())
}
