defmodule KitchenCalculator do
  @type unit() :: atom()
  @type volume_pair() :: {unit(), number()}

  @units_and_ratios [
    {:cup, 240},
    {:fluid_ounce, 30},
    {:teaspoon, 5},
    {:tablespoon, 15},
    {:milliliter, 1},
  ]

  @spec get_volume(volume_pair()) :: number()
  def get_volume({_, volume}), do: volume

  @spec to_milliliter(volume_pair()) :: volume_pair()
  Enum.each(@units_and_ratios, fn {unit, ratio} -> 
    def to_milliliter({unquote(unit), volume}), do: {:milliliter, volume * unquote(ratio)}
  end)

  @spec from_milliliter(volume_pair(), unit()) :: volume_pair()
  Enum.each(@units_and_ratios, fn {unit, ratio} -> 
    def from_milliliter({:milliliter, volume}, unquote(unit)), do: {unquote(unit), volume / unquote(ratio)}
  end)

  @spec convert(volume_pair(), unit()) :: volume_pair()
  def convert(volume_pair, unit), do: volume_pair |> to_milliliter() |> from_milliliter(unit)
end
