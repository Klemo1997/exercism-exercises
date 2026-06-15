colors = [:black, :brown, :red, :orange, :yellow, :green, :blue, :violet, :grey, :white]
units_with_bases = [{10**9, :gigaohms}, {10**6, :megaohms}, {10**3, :kiloohms}, {1, :ohms}]

defmodule ResistorColorTrio do

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([band1, band2, band3 | _]) do
    digits(band1, band2)
    |> zeros(band3)
    |> si_unit()
  end

  defp digits(band1, band2), do: digit(band1) * 10 + digit(band2)

  defp zeros(number, band), do: number * (10 ** digit(band))

  defp si_unit(0), do: {0, :ohms}
  Enum.each(units_with_bases, fn {base, unit} -> 
    defp si_unit(ohms) when ohms >= unquote(base), do: {div(ohms, unquote(base)), unquote(unit)}
  end)
  defp si_unit(ohms), do: {ohms, :ohms}
  
  Enum.each(Enum.with_index(colors), fn {color, val} -> 
    defp digit(unquote(color)), do: unquote(val)
  end)
end
