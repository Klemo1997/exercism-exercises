defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    distance = euclidean_distance({0, 0}, {x, y})
    get_score(distance)
  end

  defp get_score(distance) when distance <= 1, do: 10
  defp get_score(distance) when distance <= 5, do: 5
  defp get_score(distance) when distance <= 10, do: 1
  defp get_score(_), do: 0

  defp euclidean_distance({x1, y1}, {x2, y2}), do: :math.sqrt((x1-x2) ** 2 + (y1-y2) ** 2)
end
