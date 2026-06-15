defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price))
  end

  def with_missing_price(inventory) do
    inventory
    |> Enum.filter(&(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    replacer = get_item_name_replacer(old_word, new_word)

    inventory
    |> Enum.map(replacer)
  end

  defp get_item_name_replacer(old_word, new_word) do
    fn item -> %{
      item |
      name: String.replace(item.name, old_word, new_word)
    }
    end
  end

  def increase_quantity(item, count) do
    new_quantities = item.quantity_by_size
        |> Map.new(fn {size, current_count} -> {size, current_count + count} end)

    Map.put(item, :quantity_by_size, new_quantities)
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_, count}, acc -> acc + count end)
  end
end
