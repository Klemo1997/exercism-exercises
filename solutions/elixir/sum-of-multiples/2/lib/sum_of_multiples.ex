defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors), 
    do: (for n <- 1..limit-1, 
      Enum.any?(factors, &(&1 != 0 and rem(n, &1) == 0)), 
      reduce: 0, 
      do: (sum -> sum + n))
end
