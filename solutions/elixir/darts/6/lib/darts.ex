defmodule Darts do
  @type coordinates :: {number, number}
  @type position :: coordinates | {:classic_board, coordinates}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({:classic_board, position}),
    do: position
        |> zone_classic()
        |> points_classic()
  def score(position),
    do: position
        |> zone()
        |> points()

  defp zone(position),
    do: position
        |> radius()
        |> circle()

  defp points(:inner), do: 10
  defp points(:middle), do: 5
  defp points(:outer), do: 1
  defp points(:outside), do: 0

  defp zone_classic(position),
    do: {ring(position), section(position)}

  defp points_classic({:bullseye, _}), do: 50
  defp points_classic({:outer_bull, _}), do: 25
  defp points_classic({:inner, section}), do: section
  defp points_classic({:triple, section}), do: 3 * section
  defp points_classic({:outer, section}), do: section
  defp points_classic({:double, section}), do: 2 * section
  defp points_classic({:outside, _}), do: 0

  defp ring(position),
    do: position
      |> radius()
      |> circle_classic()

  defp section(position),
    do: position
      |> degrees()
      |> sector()

  defp circle(radius) when radius <= 1, do: :inner
  defp circle(radius) when radius <= 5, do: :middle
  defp circle(radius) when radius <= 10, do: :outer
  defp circle(_), do: :outside

  defp circle_classic(radius) when radius <= 1, do: :bullseye
  defp circle_classic(radius) when radius <= 2, do: :outer_bull
  defp circle_classic(radius) when radius <= 4, do: :inner
  defp circle_classic(radius) when radius <= 5, do: :triple
  defp circle_classic(radius) when radius <= 7, do: :outer
  defp circle_classic(radius) when radius <= 8, do: :double
  defp circle_classic(_), do: :outside

  defp sector(degrees) when degrees <= 9, do: 6
  defp sector(degrees) when degrees <= 27, do: 13
  defp sector(degrees) when degrees <= 45, do: 4
  defp sector(degrees) when degrees <= 63, do: 18
  defp sector(degrees) when degrees <= 81, do: 1
  defp sector(degrees) when degrees <= 99, do: 20
  defp sector(degrees) when degrees <= 117, do: 5
  defp sector(degrees) when degrees <= 135, do: 12
  defp sector(degrees) when degrees <= 153, do: 9
  defp sector(degrees) when degrees <= 171, do: 14
  defp sector(degrees) when degrees <= 189, do: 11
  defp sector(degrees) when degrees <= 207, do: 8
  defp sector(degrees) when degrees <= 225, do: 16
  defp sector(degrees) when degrees <= 243, do: 7
  defp sector(degrees) when degrees <= 261, do: 19
  defp sector(degrees) when degrees <= 279, do: 3
  defp sector(degrees) when degrees <= 297, do: 17
  defp sector(degrees) when degrees <= 315, do: 2
  defp sector(degrees) when degrees <= 333, do: 15
  defp sector(degrees) when degrees <= 351, do: 10
  defp sector(degrees) when degrees <= 365, do: 6

  defp degrees({x, y}), do: (:math.atan2(y, x) * 180) / :math.pi

  defp radius({x, y}), do: :math.sqrt(x ** 2 + y ** 2)
end