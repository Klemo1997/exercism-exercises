defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand), do: sqrt(radicand)

  defp sqrt(n, i \\ 1)
  defp sqrt(n, i) when n === i * i, do: i
  defp sqrt(n, i) when n < i * i, do: -1
  defp sqrt(n, i), do: sqrt(n, i + 1)
end
