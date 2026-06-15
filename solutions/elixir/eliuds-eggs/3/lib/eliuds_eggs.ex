defmodule EliudsEggs do
  import Bitwise

  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(number), do: egg_count(number, 0)

  defp egg_count(0, c), do: c
  defp egg_count(n, c), do: egg_count(n >>> 1, c + (n &&& 1))
end
