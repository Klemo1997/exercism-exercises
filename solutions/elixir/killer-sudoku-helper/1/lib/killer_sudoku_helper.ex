defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(cage), do: combinations(cage, [], [])

  defp combinations(%{size: 0, sum: 0}, combinations, combination), do: [Enum.reverse(combination) | combinations]
  defp combinations(%{size: 0}, combinations, _), do: combinations
  defp combinations(%{exclude: excluded, size: n, sum: s}, combinations, combination) do
    min = List.first(combination, 1)
    for candidate <- 9..min, candidate <= s, candidate not in excluded, reduce: combinations do
      combinations ->
        %{exclude: [candidate | excluded], size: n - 1, sum: s - candidate}
        |> combinations(combinations, [candidate | combination])
    end
  end
end
