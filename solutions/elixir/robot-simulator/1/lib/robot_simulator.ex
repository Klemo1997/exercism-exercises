defmodule RobotSimulator do
  @type robot() :: any()
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  @enforce_keys [:direction, :position]
  defstruct [:direction, :position]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, _) when direction not in [:north, :east, :south, :west],
    do: {:error, "invalid direction"}
  def create(direction, {x, y} = position) when is_integer(x) and is_integer(y),
    do: %__MODULE__{direction: direction, position: position}
  def create(_, _invalid_position), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, <<"R", instructions::binary>>), 
    do: robot |> rotate(:clockwise) |> simulate(instructions)
  def simulate(robot, <<"L", instructions::binary>>), 
    do: robot |> rotate(:counter_clockwise) |> simulate(instructions)
  def simulate(robot, <<"A", instructions::binary>>),
    do: robot |> advance() |> simulate(instructions)
  def simulate(robot, <<>>), do: robot
  def simulate(_robot, <<_, _::binary>>), do: {:error, "invalid instruction"}

  defp rotate(%__MODULE__{direction: :north} = robot, :counter_clockwise), do: %{robot | direction: :west}
  defp rotate(%__MODULE__{direction: :west} = robot, :counter_clockwise), do: %{robot | direction: :south}
  defp rotate(%__MODULE__{direction: :south} = robot, :counter_clockwise), do: %{robot | direction: :east}
  defp rotate(%__MODULE__{direction: :east} = robot, :counter_clockwise), do: %{robot | direction: :north}
  
  defp rotate(%__MODULE__{direction: :north} = robot, :clockwise), do: %{robot | direction: :east}
  defp rotate(%__MODULE__{direction: :west} = robot, :clockwise), do: %{robot | direction: :north}
  defp rotate(%__MODULE__{direction: :south} = robot, :clockwise), do: %{robot | direction: :west}
  defp rotate(%__MODULE__{direction: :east} = robot, :clockwise), do: %{robot | direction: :south}

  defp advance(%__MODULE__{position: {x, y}, direction: :north} = robot), do: %{robot | position: {x, y + 1}}
  defp advance(%__MODULE__{position: {x, y}, direction: :west} = robot), do: %{robot | position: {x - 1, y}}
  defp advance(%__MODULE__{position: {x, y}, direction: :south} = robot), do: %{robot | position: {x, y - 1}}
  defp advance(%__MODULE__{position: {x, y}, direction: :east} = robot), do: %{robot | position: {x + 1, y}}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(%__MODULE{direction: direction}), do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(%__MODULE{position: position}), do: position
end
