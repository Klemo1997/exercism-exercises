defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value(items, maximum_weight) do
    maximum_value(Enum.with_index(items), maximum_weight, 0)
  end

  defp maximum_value(items, 0, _), do: 0
  defp maximum_value(items, maximum_weight, min_index) do
    for {%{value: value, weight: weight} = item, index} <- items, 
        index >= min_index, weight <= maximum_weight,
        reduce: 0 do
      max_value ->
        max(max_value, maximum_value(items, maximum_weight - weight, index + 1) + value)
    end
  end
end
