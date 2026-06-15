defmodule Gigasecond do
  @gigasecond 10**9

  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}),
    do: with(
      date_time <- %NaiveDateTime{year: year, month: month, day: day, hour: hours, minute: minutes, second: seconds},
      %NaiveDateTime{year: y, month: m, day: d, hour: h, minute: i, second: s} <- NaiveDateTime.add(date_time, @gigasecond, :second),
      do: {{y, m, d}, {h, i, s}}
    )
end
