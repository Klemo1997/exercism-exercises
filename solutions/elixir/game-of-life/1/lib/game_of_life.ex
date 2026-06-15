defmodule GameOfLife do
  alias GameOfLife.Grid

  @doc """
  Apply the rules of Conway's Game of Life to a grid of cells
  """
  @spec tick(matrix :: list(list(0 | 1))) :: list(list(0 | 1))
  def tick([]), do: []
  def tick(matrix) do
    grid = Grid.new(matrix)

    for i <- 0..Grid.rows(grid) - 1 do
      for j <- 0..Grid.cols(grid) - 1 do
        item = Grid.item(grid, i, j)
        alive_neighbors = Grid.alive_neighbors(grid, item)

        case {Grid.alive?(grid, item), alive_neighbors} do
          {true, 2} -> item
          {true, 3} -> item
          {true, _} -> Grid.kill_item(item)
          {false, 3} -> Grid.revive_item(item)
          {false, _} -> item
        end
        |> then(fn {value, _, _} -> value end)
      end
    end
  end
end

defmodule GameOfLife.Grid do
  defstruct [:grid, :rows, :cols]

  def new([row | _] = matrix) do
    %__MODULE__{
      grid: List.to_tuple(Enum.map(matrix, &List.to_tuple/1)),
      rows: length(matrix),
      cols: length(row),
    }
  end

  def item(%__MODULE__{grid: grid, rows: rows, cols: cols}, i, j) 
      when i in 0..rows-1 and j in 0..cols-1,
    do: grid |> elem(i) |> elem(j) |> then(fn value -> {value, i, j} end)
  def item(%__MODULE__{}, _, _), do: nil

  def kill_item({_, i, j}), do: {0, i, j}

  def revive_item({_, i, j}), do: {1, i, j}

  def alive_neighbors(%__MODULE__{rows: rows, cols: cols} = grid, {_, i, j}) 
      when i in 0..rows-1 and j in 0..cols-1 do
    for neighbor_i <- i-1..i+1, neighbor_j <- j-1..j+1, not (neighbor_i == i && neighbor_j == j), reduce: 0 do
      alive_neighbors ->
        item = item(grid, neighbor_i, neighbor_j)
        if item && alive?(grid, item), do: alive_neighbors + 1, else: alive_neighbors
    end
  end

  def alive?(%__MODULE__{grid: grid, rows: rows, cols: cols}, {value, i, j}), do: value == 1

  def rows(%__MODULE{rows: rows}), do: rows
  def cols(%__MODULE{cols: cols}), do: cols
end
