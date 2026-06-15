defmodule StateOfTicTacToe do
  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """
  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board_input) do
    with board <- board(board_input),
      :ok <- check(board),
      o_won? <- win?(board, ?O),
      x_won? <- win?(board, ?X) do
      cond do
        o_won? and x_won? -> {:error, "Impossible board: game should have ended after the game was won"}
        o_won? or x_won? -> {:ok, :win}
        ongoing?(board) -> {:ok, :ongoing}
        true -> {:ok, :draw}
      end
    end  
  end

  defp board(<<a, b, c, ?\n, d, e, f, ?\n, g, h, i, _::binary>>),
    do: {
      {a, b, c},
      {d, e, f},
      {g, h, i},
    }

  defp check(board) do
    x_count = Enum.count(elems(board), &(&1 == ?X))
    o_count = Enum.count(elems(board), &(&1 == ?O))
    cond do
      x_count < o_count -> {:error, "Wrong turn order: O started"}
      x_count > o_count + 1 -> {:error, "Wrong turn order: X went twice"}
      true -> :ok
    end
  end

  defp win?({
    {p, _, _},
    {_, p, _},
    {_, _, p}
  }, p), do: true
  defp win?({
    {_, _, p},
    {_, p, _},
    {p, _, _}
  }, p), do: true
  defp win?(board, player) do
    for i <- 0..2, reduce: false do
      true -> true
      false -> row(board, i) == [player, player, player]
               or col(board, i) == [player, player, player]
    end
  end

  defp ongoing?(board), do: ?. in elems(board)

  defp elems(board), do: Tuple.to_list(board) |> Enum.flat_map(&Tuple.to_list/1)
  defp row(board, index), do: elem(board, index) |> Tuple.to_list()
  defp col(board, index), do: 0..2 |> Enum.map(&elem(elem(board, &1), index))
end
