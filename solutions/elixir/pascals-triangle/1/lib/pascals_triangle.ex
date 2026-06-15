defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num), do: collect_rows(num, [])

  defp collect_rows(0, rows), do: Enum.reverse(rows)
  defp collect_rows(n, []), do: collect_rows(n-1, [[1]])
  defp collect_rows(n, [row | rows]), do: collect_rows(n-1, [collect_row(row), row | rows])

  defp collect_row(prev_row, prev_n \\ 0, next_row \\ [])
  defp collect_row([], prev_n, next_row), do: Enum.reverse([prev_n | next_row])
  defp collect_row([n | prev_row], prev_n, next_row), do: collect_row(prev_row, n, [n + prev_n | next_row])
end
