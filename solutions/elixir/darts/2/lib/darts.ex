defmodule Darts do
  @type position :: {number, number}
  @inner_circle_radius 1
  @middle_circle_radius 5
  @outer_circle_radius 10

  @inner_circle_score 10
  @middle_circle_score 5
  @outer_circle_score 1

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score(position), 
    do: euclidean_distance_from_middle(position)
      |> score_from_distance

  defp score_from_distance(distance) when distance <= @inner_circle_radius, do: @inner_circle_score
  defp score_from_distance(distance) when distance <= @middle_circle_radius, do: @middle_circle_score
  defp score_from_distance(distance) when distance <= @outer_circle_radius, do: @outer_circle_score
  defp score_from_distance(_), do: 0

  defp euclidean_distance_from_middle({x, y}), do: :math.sqrt(x ** 2 + y ** 2)
end
