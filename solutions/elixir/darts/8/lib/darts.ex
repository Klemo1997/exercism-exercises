defmodule Darts do
  @type coordinates :: {number, number}
  @type position :: coordinates | {:classic_board, coordinates}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score(position),
    do: position
        |> zone()
        |> points()

  defp zone({:classic_board, position}) do
    case ring_value(position) do
      fixed_value when fixed_value in [:bullseye, :outer_bull, :outside] -> fixed_value
      multiplier -> {multiplier, sector_value(position)}
    end
  end
  defp zone(position),
    do: position
        |> radius()
        |> circle()

  defp points(:inner), do: 10
  defp points(:middle), do: 5
  defp points(:outer), do: 1

  defp points(:bullseye), do: 50
  defp points(:outer_bull), do: 25
  defp points({:single, section}), do: section
  defp points({:double, section}), do: 2 * section
  defp points({:triple, section}), do: 3 * section
  defp points(:outside), do: 0

  defp ring_value(position = {_, _}), do: ring_value(radius(position))
  defp ring_value(radius) when radius <= 1, do: :bullseye
  defp ring_value(radius) when radius <= 2, do: :outer_bull
  defp ring_value(radius) when radius <= 4, do: :single
  defp ring_value(radius) when radius <= 5, do: :triple
  defp ring_value(radius) when radius <= 7, do: :single
  defp ring_value(radius) when radius <= 8, do: :double
  defp ring_value(_), do: :outside

  defp sector_value({x, y}),
    do: (
      with degrees <- trunc(:math.atan2(y, x) * 180 / :math.pi),
      index <- trunc(rem(degrees + 279, 360) / 18),
      do: elem({20, 5, 12, 9, 14, 11, 8, 16, 7, 19, 3, 17, 2, 15, 10, 6, 13, 4, 18, 1}, index)
    )

  defp circle(radius) when radius <= 1, do: :inner
  defp circle(radius) when radius <= 5, do: :middle
  defp circle(radius) when radius <= 10, do: :outer
  defp circle(_), do: :outside

  defp radius({x, y}), do: :math.sqrt(x ** 2 + y ** 2)
end