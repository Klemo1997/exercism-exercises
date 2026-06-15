defmodule BoutiqueSuggestions do
  @type item() :: %{item_name: String.t(), price: number(), base_color: String.t()}

  @default_max_price 100

  @spec get_combinations(list(item()), list(item())) :: keyword()
  def get_combinations(tops, bottoms, options \\ []) do
    max_price = Keyword.get(options, :maximum_price, @default_max_price)

    for %{base_color: top_color, price: top_price} = top <- tops,
        %{base_color: bottom_color, price: bottom_price} = bottom <- bottoms,
        top_color !== bottom_color,
        top_price + bottom_price <= max_price do
      {top, bottom}
    end
  end
end
