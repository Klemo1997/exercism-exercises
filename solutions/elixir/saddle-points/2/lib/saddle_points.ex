defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(""), do: []
  def rows(str) do
    for row <- String.split(str, "\n") do
      String.split(row)
      |> Enum.map(&String.to_integer/1)
    end
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(""), do: []
  def columns(str) do
    rows(str)
    |> transpose()
  end

  defp transpose(matrix) do
    matrix
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    rows = rows(str)
    cols = columns(str)
    row_maxes = rows |> Enum.map(&Enum.max/1) |> List.to_tuple()
    col_mins = cols |> Enum.map(&Enum.min/1) |> List.to_tuple()
    
    for {row, i} <- Enum.with_index(rows),
        {n, j} <- Enum.with_index(row),
        _smallest_in_col? = elem(col_mins, j) == n,
        _largest_in_row? = elem(row_maxes, i) == n do
        {i+1, j+1}
    end  
  end
end
