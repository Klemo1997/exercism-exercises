defmodule BoutiqueSuggestions do
  @default_max_price 100

  def get_combinations(tops, bottoms, options \\ []) do
    max_price = Keyword.get(options, :maximum_price, @default_max_price)
    for %{base_color: top_color, price: top_price} = top <- tops,
        %{base_color: bottom_color, price: bottom_price} = bottom <- bottoms,
        top_color !== bottom_color,
        not exceeds_price(top_price + bottom_price, max_price) do
      {top, bottom}
    end
  end

  defp exceeds_price(price, maximum_price), do: price > maximum_price
end
