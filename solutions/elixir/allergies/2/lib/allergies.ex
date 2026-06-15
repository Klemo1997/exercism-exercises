defmodule Allergies do
  import Bitwise

  @allergies [
    "eggs",
    "peanuts",
    "shellfish",
    "strawberries",
    "tomatoes",
    "chocolate",
    "pollen",
    "cats",
  ]

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags),
    do: Enum.with_index(@allergies)
      |> Enum.filter(fn {_, flag} -> Bitwise.band(flags, (1 <<< flag)) !== 0 end)
      |> Enum.map(&elem(&1, 0))

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item),
    do: Enum.find_index(@allergies, &(&1 === item))
      |> then(fn flag when is_integer(flag) -> Bitwise.band(flags, (1 <<< flag)) !== 0 end)
end
