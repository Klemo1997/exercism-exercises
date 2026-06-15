defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    # Please implement the get_volume/1 functionKe
    {_, volume} = volume_pair
    volume
  end

  def to_milliliter(volume_pair) do
    {from_type, volume} = volume_pair
    
    multiplier = get_multiplier_to_milliliter(from_type)
    
    {:milliliter, volume * multiplier}
  end

  defp get_multiplier_to_milliliter(type) do
    case type do
      :cup -> 240
      :fluid_ounce -> 30
      :teaspoon -> 5
      :tablespoon -> 15
      :milliliter -> 1
      true -> raise "Invalid unit type" + type
    end
  end

  def from_milliliter(volume_pair, unit) do
    new_volume =
      get_volume(volume_pair) / get_multiplier_to_milliliter(unit)
    {unit, new_volume}
  end

  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter
    |> from_milliliter(unit)
  end
end
