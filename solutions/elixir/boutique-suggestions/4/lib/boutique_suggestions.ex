defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    max_price = Keyword.get(options, :maximum_price, 100.0)

    for top <- tops,
        bottom <- bottoms,
        (
           not combination_has_same_colors?(top, bottom)
           and not exceeds_max_price?(top, bottom, max_price)
        ) do
      {top, bottom}
    end
  end

  defp combination_has_same_colors?(top, bottom), do: top.base_color == bottom.base_color

  defp exceeds_max_price?(top, bottom, max_price), do: top.price + bottom.price > max_price
end
