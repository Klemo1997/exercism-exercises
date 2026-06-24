defmodule Alphametics do
  @type puzzle :: binary
  @type solution :: %{required(?A..?Z) => 0..9}

  @doc """
  Takes an alphametics puzzle and returns a solution where every letter
  replaced by its number will make a valid equation. Returns `nil` when
  there is no valid solution to the given puzzle.

  ## Examples

    iex> Alphametics.solve("I + BB == ILL")
    %{?I => 1, ?B => 9, ?L => 0}

    iex> Alphametics.solve("A == B")
    nil
  """
  @spec solve(puzzle) :: solution | nil
  def solve(puzzle) do
    with {:ok, [left_puzzle, right_puzzle]} <- parse(puzzle) do
      candidates(left_puzzle, right_puzzle)
      |> Enum.find(&(number(left_puzzle, &1) == number(right_puzzle, &1)))
    end
  end

  defp parse(puzzle) do
    with parts <- String.split(puzzle, "=="),
         [_, _] <- parts do
      puzzle_parts = Enum.map(parts, fn part -> 
        String.trim(part)
        |> String.split(" + ")
        |> Enum.map(&String.to_charlist/1)
      end)
      {:ok, puzzle_parts}
    else
      _ -> {:error, "invalid input puzzle"}
    end
  end

  defp number(puzzle, mapping),
    do: Enum.reduce(puzzle, 0, fn puzzle_part, sum -> 
      sum + Integer.undigits(Enum.map(puzzle_part, &mapping[&1]))
    end)
  
  defp candidates(left_parts, right_parts) do
    letters = Enum.flat_map([left_parts, right_parts], fn a -> a end) |> Enum.flat_map(fn a -> a end) |> Enum.uniq()
    Enum.reduce(letters, %{}, fn
      letter, letter_map when not is_map_key(letter_map, letter) ->
        first? = any_first?(left_parts, letter) or any_first?(right_parts, letter)
        range = if first?, do: 1..9, else: 0..9
        Map.put(letter_map, letter, range)
      _, letter_map -> letter_map
    end)
    |> candidate_stream()
  end

  defp any_first?(parts, letter), do: Enum.any?(parts, fn [first | _] -> first == letter end)

  defp candidate_stream(map),
    do: Map.to_list(map)
      |> candidate_stream(%{}, MapSet.new())
  
  defp candidate_stream([], acc, _used), do: Stream.map([acc], &(&1))
  defp candidate_stream([{letter, range} | rest], acc, used) do
    Stream.flat_map(range, fn value ->
      if MapSet.member?(used, value) do
        Stream.map([], & &1)
      else
        candidate_stream(rest, Map.put(acc, letter, value), MapSet.put(used, value))
      end
    end)
  end
end
