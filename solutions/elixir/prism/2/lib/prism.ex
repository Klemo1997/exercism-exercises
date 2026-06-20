defmodule Prism do
  @doc """
  Finds the sequence of prisms that the laser will hit.
  """

  @type start :: %{angle: number(), x: number(), y: number()}
  @type prism :: %{id: integer(), angle: number(), x: number(), y: number()}

  @spec find_sequence(prisms :: [prism()], start :: start()) :: [integer()]
  def find_sequence(prisms, start, sequence \\ [])
  def find_sequence(prisms, start, sequence) do
    case closest_point_in_ray_path(prisms, start) do
      nil -> 
        Enum.reverse(sequence)
      prism -> 
        find_sequence(prisms, %{angle: start.angle + prism.angle, x: prism.x, y: prism.y}, [prism.id | sequence])
    end
  end

  defp closest_point_in_ray_path(points, start) do
    angle = start.angle * :math.pi() / 180
    cos = :math.cos(angle)
    sin = :math.sin(angle)
    eps = 1.0e-2

    points
    |> Enum.filter(fn prism -> 
      dx = prism.x - start.x
      dy = prism.y - start.y
  
      cross = dx * sin - dy * cos
      dot = dx * cos + dy * sin
      self? = dx == 0 and dy == 0
        
      not self? and abs(cross) < eps and dot >= 0
    end)
    |> then(fn
      [] -> nil
      crossing_points -> 
        Enum.min_by(crossing_points, fn prism -> 
          dx = prism.x - start.x
          dy = prism.y - start.y
          _dist = dx * cos + dy * sin
        end)
      end)
  end
end