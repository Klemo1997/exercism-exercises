pub fn expected_minutes_in_oven() {
  40
}

pub fn remaining_minutes_in_oven(minutes_in_oven: Int) {
  expected_minutes_in_oven() - minutes_in_oven
}

pub fn preparation_time_in_minutes(layers: Int) {
  layers * 2
}

pub fn total_time_in_minutes(layers: Int, minutes_in_oven: Int) {
  preparation_time_in_minutes(layers) + minutes_in_oven
}

pub fn alarm() {
  "Ding!"
}
