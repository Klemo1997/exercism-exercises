defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    exceeds_max_price = get_exceeds_max_price_predicate(options[:maximum_price] || 100.0)

    combinations = for top <- tops,
        bottom <- bottoms,
        (
           not combination_has_same_colors?(top, bottom)
           and not exceeds_max_price.({top, bottom})
        ) do
      {top, bottom}
    end
  end

  defp combination_has_same_colors?(top, bottom) do
    Map.get(top, :base_color) == Map.get(bottom, :base_color)
  end

  defp get_exceeds_max_price_predicate(max_price) do
    fn {top, bottom} ->
      total = Map.get(top, :price) + Map.get(bottom, :price)
      total > max_price
    end
  end
end
