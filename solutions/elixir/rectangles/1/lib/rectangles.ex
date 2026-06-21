defmodule Rectangles do
  @doc """
  Count the number of ASCII rectangles.
  """
  @spec count(input :: String.t()) :: integer
  def count(""), do: 0
  def count(input) do
    plane = plane(input)
    {m, n} = plane.(:dimensions)
    for x <- 0..m-1, y <- 0..n-1, plane.({:at, {x, y}}) == ?+, reduce: 0 do
      squares -> squares + squares_at(plane, {x, y})
    end
  end

  defp plane(input) do
    char_matrix = String.split(input, "\n", trim: true)
      |> Enum.map(&List.to_tuple(String.to_charlist(&1)))
      |> List.to_tuple()
    m = tuple_size(char_matrix)
    n = tuple_size(elem(char_matrix, 0))
    fn
      {:at, {x, y}} when x >= m or y >= n -> {:error, :out_of_bounds}
      {:at, {x, y}} -> char_matrix |> elem(x) |> elem(y)
      :dimensions -> {m, n}
    end
  end

  defp squares_at(plane, {x, y}), do: squares_at(plane, {x, y}, {x, y}, 0)
  
  @doc """
  Checks number of squares from two points horizontally
  """
  defp squares_at(plane, {x, y}, {current_x, current_y}, total) do
    next_y = current_y + 1
    case plane.({:at, {current_x, next_y}}) do
      ?- -> squares_at(plane, {x, y}, {current_x, next_y}, total)
      ?+ ->
        vertical_count = squares_at(plane, {x, y}, {current_x, next_y}, {current_x, next_y}, 0)
        squares_at(plane, {x, y}, {current_x, next_y}, total + vertical_count)
      _ -> total # either invalid square or out of bounds
    end
  end

  @doc """
  Checks number of squares from two points vertically
  """
  defp squares_at(plane, {x, y}, {x, y2}, {current_x, current_y}, total) do
    # checks every row between x + 1 and m - 1 for valid squares
    next_x = current_x + 1
    case {plane.({:at, {next_x, y}}), plane.({:at, {next_x, y2}})} do
      {?|, ?|} -> squares_at(plane, {x, y}, {x, y2}, {next_x, current_y}, total)
      {?+, ?|} -> squares_at(plane, {x, y}, {x, y2}, {next_x, current_y}, total)
      {?|, ?+} -> squares_at(plane, {x, y}, {x, y2}, {next_x, current_y}, total)
      {?+, ?+} ->
        total = if connected?(plane, {next_x, y}, {next_x, y2}), do: total + 1, else: total
        squares_at(plane, {x, y}, {x, y2}, {next_x, current_y}, total)
      _ -> total # either invalid square or out of bounds
    end
  end

  @doc """
  Checks if two points (on a same horizontal line) are connected so they can form bottom side
  of a square
  """
  defp connected?(_, {x, y}, {x, y}), do: true
  defp connected?(plane, {x, y1}, {x, y2}) do
    case plane.({:at, {x, y1}}) do
      ?- -> connected?(plane, {x, y1 + 1}, {x, y2})
      ?+ -> connected?(plane, {x, y1 + 1}, {x, y2})
      _ -> false
    end
  end
end
