defmodule ResistorColorTrio do
  @colors [:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white]
  @units [:ohms, :kiloohms, :megaohms, :gigaohms]

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([first, second, third | _]) do
    ohms({first, second, third})
    |> normalize_with_unit()
  end

  defp normalize_with_unit(value, unit \\ :ohms)
  Enum.each(Enum.chunk_every(@units, 2, 1, :discard), fn [unit, next_unit] -> 
    defp normalize_with_unit(value, unquote(unit)) when value > 1000, do: normalize_with_unit(div(value, 1000), unquote(next_unit))
  end)
  defp normalize_with_unit(value, unit), do: {value, unit}

  defp ohms({first, second, third}),
    do: "#{color_value(first)}#{color_value(second)}#{String.duplicate("0", color_value(third))}"
      |> String.to_integer()
  
  Enum.each(Enum.with_index(@colors), fn {color, val} -> 
    defp color_value(unquote(color)), do: unquote(val)
  end)
end
