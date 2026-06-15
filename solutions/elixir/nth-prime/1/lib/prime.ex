defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0, do: find_nth(2, count)

  defp find_nth(last_prime, 1), do: last_prime
  defp find_nth(last_prime, count), 
    do: Enum.find(last_prime+1..trunc(1.0e6), fn number -> prime?(number) end)
      |> find_nth(count - 1)

  defp prime?(2), do: true
  defp prime?(3), do: true
  defp prime?(number),
    do: Enum.all?(2..trunc(:math.sqrt(number)), fn item -> (number / item) != trunc(number/item) end)
end
