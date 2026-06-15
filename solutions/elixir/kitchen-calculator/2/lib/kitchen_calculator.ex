defmodule KitchenCalculator do
  @type unit() :: atom()
  @type volume_pair() :: {unit(), number()}

  @cup_milliliters 240
  @fluid_ounce_milliliters 30
  @teaspoon_milliliters 5
  @tablespoon_milliliters 15

  @spec get_volume(volume_pair()) :: number()
  def get_volume(volume_pair), do: elem(volume_pair, 1)

  @spec to_milliliter(volume_pair()) :: volume_pair()
  def to_milliliter({:cup, volume}) do
    {:milliliter, volume * @cup_milliliters}
  end

  def to_milliliter({:fluid_ounce, volume}) do
    {:milliliter, volume * @fluid_ounce_milliliters}
  end

  def to_milliliter({:teaspoon, volume}) do
    {:milliliter, volume * @teaspoon_milliliters}
  end

  def to_milliliter({:tablespoon, volume}) do
    {:milliliter, volume * @tablespoon_milliliters}
  end

  def to_milliliter(volume_pair = {:milliliter, volume}), do: volume_pair

  @spec from_milliliter(volume_pair(), unit()) :: volume_pair()
  def from_milliliter({:milliliter, volume}, :cup) do
    {:cup, volume / @cup_milliliters}
  end

  def from_milliliter({:milliliter, volume}, :fluid_ounce) do
    {:fluid_ounce, volume / @fluid_ounce_milliliters}
  end

  def from_milliliter({:milliliter, volume}, :teaspoon) do
    {:teaspoon, volume / @teaspoon_milliliters}
  end

  def from_milliliter({:milliliter, volume}, :tablespoon) do
    {:tablespoon, volume / @tablespoon_milliliters}
  end

  def from_milliliter(volume_pair = {:milliliter, volume}, :milliliter), do: volume_pair

  @spec convert(volume_pair(), unit()) :: volume_pair()
  def convert(volume_pair, unit) do
    volume_pair |> to_milliliter |> from_milliliter(unit)
  end
end
