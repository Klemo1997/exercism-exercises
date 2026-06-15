defmodule StateOfTicTacToe do
  @lines for(x <- 0..2, do: [{x, 0}, {x, 1}, {x, 2}])
        ++ for(y <- 0..2, do: [{0, y}, {1, y}, {2, y}])
        ++ [[{0, 0}, {1, 1}, {2, 2}], [{2, 0}, {1, 1}, {0, 2}]]

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

  defp board(<<a, b, c, ?\n, d, e, f, ?\n, g, h, i, _::binary>>) do
    board = {
      {a, b, c},
      {d, e, f},
      {g, h, i},
    }
    %{
      item: fn {x, y} -> board |> elem(x) |> elem(y) end,
      elems: fn -> [a, b, c, d, e, f, g, h, i] end
    }
  end

  defp check(board) do
    elems = board.elems.()
    x_count = Enum.count(elems, &(&1 == ?X))
    o_count = Enum.count(elems, &(&1 == ?O))
    cond do
      x_count < o_count -> {:error, "Wrong turn order: O started"}
      x_count > o_count + 1 -> {:error, "Wrong turn order: X went twice"}
      true -> :ok
    end
  end

  defp win?(board, player),
    do: Enum.any?(@lines, fn line -> Enum.all?(line, &(board.item.(&1) == player)) end)

  defp ongoing?(board), do: ?. in board.elems.()
end
