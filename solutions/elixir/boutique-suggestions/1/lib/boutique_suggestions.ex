defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    combinations = for top <- tops,
        bottom <- bottoms do
      {top, bottom}
    end

    combinations
    |> Enum.filter(&combination_has_different_colors?/1)
    |> Enum.filter(get_price_does_not_exceed_predicate(options[:maximum_price] || 100.0))
  end

  defp combination_has_different_colors?({top, bottom}) do
    Map.get(top, :base_color) != Map.get(bottom, :base_color)
  end

  defp get_price_does_not_exceed_predicate(max_price) do
    fn {top, bottom} ->
      total = Map.get(top, :price) + Map.get(bottom, :price)
      total <= max_price
    end
  end
end
