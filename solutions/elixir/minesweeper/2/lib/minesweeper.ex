defmodule Minesweeper do
  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t()]) :: [String.t()]

  def annotate([]), do: []
  def annotate([""]), do: [""]
  def annotate([row | _] = board) do
    tuple_board = 
      board
      |> Enum.map(&List.to_tuple(String.graphemes(&1)))
      |> List.to_tuple()

    rows = length(board)
    cols = String.length(row)

    item_accessor = fn 
      {row, col} when row in 0..rows-1 and col in 0..cols-1 -> 
        tuple_board |> elem(row) |> elem(col)
      {_, _} -> nil
    end

    accessor = fn
      {:item, row, col} -> item_accessor.({row, col})
      {:mines_count, row, col} ->
        (for i <- row-1..row+1, j <- col-1..col+1, do: item_accessor.({i, j}))
        |> Enum.filter(&(&1 == "*"))
        |> length()
    end

    for row <- 0..rows-1 do 
      for col <- 0..cols-1, reduce: "" do
        acc -> acc <> annotate(accessor, row, col)
      end
    end
  end

  defp annotate(accessor, row, col) do
    case accessor.({:item, row, col}) do
      " " -> 
        mines = accessor.({:mines_count, row, col})
        if mines > 0, do: <<?0 + mines>>, else: " "
      other -> other
    end
  end
end
