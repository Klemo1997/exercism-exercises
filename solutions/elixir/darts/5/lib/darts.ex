defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
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

  defp circle(radius) when radius <= 1, do: :inner
  defp circle(radius) when radius <= 5, do: :middle
  defp circle(radius) when radius <= 10, do: :outer
  defp circle(_), do: :outside

  defp radius({x, y}), do: :math.sqrt(x ** 2 + y ** 2)
end
