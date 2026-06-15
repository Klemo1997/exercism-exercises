defmodule Tournament do
  @default_table_record %{win: 0, loss: 0, draw: 0}
  @header "Team                           | MP |  W |  D |  L |  P"

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.map(&String.split(&1, ";"))
    |> Enum.reduce(%{}, &table/2)
    |> Enum.sort_by(fn {_, record} -> points(record) end, :desc)
    |> format()
  end

  defp table([home, away, "win"], table), 
    do: table
      |> increment(home, :win)
      |> increment(away, :loss)
  defp table([home, away, "draw"], table),
    do: table
      |> increment(home, :draw)
      |> increment(away, :draw)
  defp table([home, away, "loss"], table), do: table([away, home, "win"], table)
  defp table(_, table), do: table

  defp increment(table, team, result), 
    do: Map.get(table, team, @default_table_record)
      |> Map.update!(result, &(&1 + 1))
      |> then(&Map.put(table, team, &1))

  defp format(table),
    do: table
      |> Enum.map(&format_line/1)
      |> then(fn rows -> [@header | rows] end)
      |> then(&Enum.join(&1, "\n"))

  defp format_line({team, record}) do
    formatted_team = String.pad_trailing(team, 30)
    formatted_matches = matches(record) |> format_table_number()
    formatted_wins = record[:win] |> format_table_number()
    formatted_draws = record[:draw] |> format_table_number()
    formatted_losses = record[:loss] |> format_table_number()
    formatted_points = points(record) |> format_table_number()

    Enum.join([formatted_team, formatted_matches, formatted_wins, formatted_draws, formatted_losses, formatted_points], " | ")
  end

  defp format_table_number(n) when is_integer(n),
    do: n
      |> to_string()
      |> String.pad_leading(2)

  defp matches(%{win: win, loss: loss, draw: draw}), do: win + loss + draw

  defp points(%{win: win, draw: draw}), do: win * 3 + draw
end
