defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    sqrt(radicand)
  end

  defp sqrt(n, i \\ 1) do
    case n do
      n when n == i*i -> i
      n when n < i*i -> -1
      _ -> sqrt(n, i+1)
    end
  end
end
