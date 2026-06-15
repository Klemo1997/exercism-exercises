defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) when size > 0,
    do: number_string
    |> to_charlist()
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.map(&product/1)
    |> Enum.max(fn -> raise ArgumentError end)
    
  def largest_product(_, _), do: raise ArgumentError

  defp product(numbers),
    do: Enum.reduce(numbers, 1, fn 
        n, product when n in ?0..?9 -> product * (n - ?0)
        _, _ -> raise ArgumentError
      end)
end
