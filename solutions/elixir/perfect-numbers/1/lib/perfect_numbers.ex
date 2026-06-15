defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when is_integer(number) and number > 0 do
    {number, aliquot_sum(number)}
    |> then(fn 
      {n, n} -> :perfect
      {n, sum} when sum > n -> :abundant
      _ -> :deficient
    end)
    |> then(&{:ok, &1})
  end
  def classify(_), do: {:error, "Classification is only possible for natural numbers."}

  defp aliquot_sum(1), do: 0
  defp aliquot_sum(n) do
    for factor <- 1..ceil(n/2), rem(n, factor) == 0, reduce: 0 do
      sum -> sum + factor
    end
  end
end
