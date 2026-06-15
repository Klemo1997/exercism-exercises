defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    Enum.flat_map(factors, fn 
      0 -> []
      factor -> Enum.filter(factor..limit-1//1, &(rem(&1, factor) === 0)) 
    end)
    |> Enum.uniq()
    |> Enum.sum()
  end
end
