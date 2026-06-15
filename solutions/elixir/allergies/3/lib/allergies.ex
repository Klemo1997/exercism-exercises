defmodule Allergies do
  import Bitwise, only: [band: 2]

  @allergies ~w[eggs peanuts shellfish strawberries tomatoes chocolate pollen cats]
  @allergies_with_flags Enum.with_index(@allergies) |> Enum.map(fn {allergy, index} -> {allergy, 2**index} end)

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags), do: (for {allergy, flag} <- @allergies_with_flags, band(flags, flag) !== 0, do: allergy)

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item)
  Enum.each(@allergies_with_flags, fn {allergy, flag} -> 
    def allergic_to?(flags, unquote(allergy)), do: band(flags, unquote(flag)) !== 0
  end)
end
