defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []
  def matrix(dimension) do
    dimension
    |> create_matrix()
    |> fill()
    |> to_list(dimension)
  end

  defp create_matrix(dim),
    do: for(
      row <- 1..dim,
      col <- 1..dim,
      into: %{},
      do: {{row-1, col-1}, :empty}
    )

  defp to_list(matrix, dim) do
    for (row <- 1..dim) do
      for (col <- 1..dim), do: matrix[{row-1, col-1}]
    end
  end

  defp fill(matrix, {coord, dir, val} \\ {{0, -1}, {0, 1}, 1}) do
    case next_empty_cell(matrix, coord, dir) do
      {coord, dir} ->
        %{matrix | coord => val}
        |> fill({coord, dir, next_value(val)}) 
      nil -> matrix
    end
  end

  defp next_empty_cell(matrix, coord, dir) do
    next_coord = go_straight(coord, dir)

    case matrix[next_coord] do
      :empty -> {next_coord, dir}
      _ ->
        dir = turn_right(dir)
        next_coord = go_straight(coord, dir)

        if matrix[next_coord] == :empty do
          {next_coord, dir} 
        end
    end
  end

  defp go_straight({r, c}, {dr, dc}), do: {r + dr, c + dc}

  defp turn_right({0, 1}), do: {1, 0}
  defp turn_right({1, 0}), do: {0, -1}
  defp turn_right({0, -1}), do: {-1, 0}
  defp turn_right({-1, 0}), do: {0, 1}

  defp next_value(n), do: n + 1
end
