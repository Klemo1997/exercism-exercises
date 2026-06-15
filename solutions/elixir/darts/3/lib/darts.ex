defmodule Darts do
  @type position :: {number, number}
  @type zone :: :inner | :middle | :outer | :outside

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score(position), 
    do: position 
        |> zone() 
        |> points()

  @spec zone(position) :: zone
  defp zone(position),
    do: position
        |> distance()
        |> then(
          fn 
            distance when distance <= 1 -> :inner
            distance when distance <= 5 -> :middle
            distance when distance <= 10 -> :outer
            _distance -> :outside
          end
        )

  @spec points(zone) :: number
  defp points(:inner), do: 10
  defp points(:middle), do: 5
  defp points(:outer), do: 1
  defp points(:outside), do: 0

  @spec distance(position) :: number
  defp distance({x, y}), do: :math.sqrt(x ** 2 + y ** 2)
end
