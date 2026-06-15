defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.flat_map(fn {points, letters} -> Enum.map(letters, &tuple(&1, points)) end) 
    |> Map.new()
  end

  defp tuple(letter, points), do: {String.downcase(letter), points}
end
