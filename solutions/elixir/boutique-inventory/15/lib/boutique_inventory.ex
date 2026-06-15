defmodule BoutiqueInventory do
  @type quantity_by_size() :: %{String.t() => non_neg_integer()}
  @type inventory_item() :: %{name: String.t(), price: pos_integer()|nil, quantity_by_size: quantity_by_size()}

  @spec sort_by_price(list(inventory_item())) :: list(inventory_item())
  def sort_by_price(inventory), 
    do: Enum.sort_by(inventory, &(&1.price))

  @spec with_missing_price(list(inventory_item())) :: list(inventory_item())
  def with_missing_price(inventory), 
    do: Enum.filter(inventory, &(&1.price === nil))

  @spec update_names(list(inventory_item()), String.t(), String.t()) :: list(inventory_item())
  def update_names(inventory, old_word, new_word), 
    do: Enum.map(inventory, &(%{&1 | name: String.replace(&1.name, old_word, new_word)}))

  @spec increase_quantity(inventory_item(), non_neg_integer()) :: quantity_by_size()
  def increase_quantity(item, count) do 
    increased_quantities = Map.new(item.quantity_by_size, fn {size, in_stock} -> 
      {size, in_stock + count}
    end)
    %{item | quantity_by_size: increased_quantities}
  end

  @spec total_quantity(inventory_item()) :: non_neg_integer()
  def total_quantity(item), 
    do: Map.values(item[:quantity_by_size]) |> Enum.reduce(0, &+/2)
end