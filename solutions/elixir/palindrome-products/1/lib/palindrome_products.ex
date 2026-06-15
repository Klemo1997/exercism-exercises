defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) when max_factor >= min_factor do
    for i <- min_factor..max_factor, j <- min_factor..max_factor, i <= j and palindrome?(i*j) do
      [i, j]
    end
    |> Enum.group_by(&Enum.product/1)
  end
  def generate(_, _), do: raise ArgumentError

  def palindrome?(n), do: palindrome?(n, n, 0)
  def palindrome?(n, 0, reverse), do: n == reverse
  def palindrome?(n, remaining, reverse), 
    do: palindrome?(n, div(remaining, 10), reverse * 10 + rem(remaining, 10))
end
