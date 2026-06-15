defmodule Matrix do
  defstruct [rows: [], columns: []]

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(<<>>), do: %Matrix{}
  def from_string(input), do: from_string(input, [[]])
  defp from_string(<<?\s, rest::binary>>, rows), do: from_string(rest, rows)
  defp from_string(<<?\n, rest::binary>>, [row | rows]), do: from_string(rest, [[], Enum.reverse(row) | rows])
  defp from_string(<<_, _::binary>> = input, [row | rows]),
    do: Integer.parse(input)
      |> then(fn
        {n, rest} -> from_string(rest, [[n | row] | rows])
        :error -> raise "Invalid input"
      end)
  defp from_string(<<>>, [row | rows]), 
    do: [Enum.reverse(row) | rows] 
      |> Enum.reverse() 
      |> then(fn rows -> %Matrix{rows: rows, columns: transpose(rows)} end)

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%Matrix{rows: rows}) do
    rows |> Enum.map(&Enum.join(&1, " ")) |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%Matrix{rows: rows}), do: rows

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(%Matrix{rows: rows}, index), do: Enum.at(rows, index-1)

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(%Matrix{columns: columns}), do: columns

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(%Matrix{columns: columns}, index), do: Enum.at(columns, index-1)

  defp transpose(rows), do: Enum.zip_with(rows, &Function.identity/1)
end
