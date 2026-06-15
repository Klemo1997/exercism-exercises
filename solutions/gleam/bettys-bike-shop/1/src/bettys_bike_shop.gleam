import gleam/int
import gleam/float

pub fn pence_to_pounds(pence: Int) {
  int.to_float(pence) /. 100.0
}

pub fn pounds_to_string(pounds: Float) {
  "£" <> float.to_string(pounds)
}
 