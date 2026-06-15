defmodule EliudsEggs do
  import Bitwise

  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(number), do: egg_count(number, 0, 1)

  defp egg_count(0, c, _), do: c
  defp egg_count(n, c, b) when (n &&& b) == b, do: egg_count(n-b, c+1, b*2)
  defp egg_count(n, c, b), do: egg_count(n, c, b*2)
end
