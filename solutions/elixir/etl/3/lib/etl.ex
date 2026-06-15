defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(old_format),
    do: (for {score, letters} <- old_format, upcase_letter <- letters, 
        into: %{}, 
        do: {String.downcase(upcase_letter), score})
end
