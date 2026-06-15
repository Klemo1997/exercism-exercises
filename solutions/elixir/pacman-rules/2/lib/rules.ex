defmodule Rules do
  @moduledoc """
    This is the module containing rules regarding Pac-Man.
  """

  @doc """
    Takes two arguments (if Pac-Man has a power pellet active and 
    if Pac-Man is touching a ghost) and returns a boolean value 
    if Pac-Man is able to eat the ghost.
  """
  @spec eat_ghost?(boolean(), boolean()) :: boolean()
  def eat_ghost?(power_pellet_active, touching_ghost), do: 
    power_pellet_active and touching_ghost

  @doc """
    Takes two arguments (if Pac-Man is touching a power pellet 
    and if Pac-Man is touching a dot) and returns a boolean 
    value if Pac-Man scored.
  """
  @spec score?(boolean(), boolean()) :: boolean()
  def score?(touching_power_pellet, touching_dot), do:
    touching_power_pellet or touching_dot

  @doc """
    Takes two arguments (if Pac-Man has a power pellet active
    and if Pac-Man is touching a ghost) and returns a boolean
    value if Pac-Man loses.
  """
  @spec lose?(boolean(), boolean()) :: boolean()
  def lose?(power_pellet_active, touching_ghost), do:
    touching_ghost and not power_pellet_active

  @doc """
    Takes three arguments (if Pac-Man has eaten all of the 
    dots, if Pac-Man has a power pellet active, and if Pac-Man
    is touching a ghost) and returns a boolean value if Pac-Man wins.
  """
  @spec win?(boolean(), boolean(), boolean()) :: boolean()
  def win?(has_eaten_all_dots, power_pellet_active, touching_ghost), do:
    has_eaten_all_dots and not lose?(power_pellet_active, touching_ghost)
end
