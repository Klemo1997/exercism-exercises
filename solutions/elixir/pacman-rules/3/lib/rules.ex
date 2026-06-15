defmodule Rules do
  @moduledoc """
    This is the module containing rules regarding Pac-Man.
  """

  @doc "Returns whether Pac-Man is able to eat the ghost."
  @spec eat_ghost?(boolean(), boolean()) :: boolean()
  def eat_ghost?(power_pellet_active, touching_ghost) do
    power_pellet_active and touching_ghost
  end

  @doc "Returns whether Pac-Man has scored."
  @spec score?(boolean(), boolean()) :: boolean()
  def score?(touching_power_pellet, touching_dot) do
    touching_power_pellet or touching_dot
  end

  @doc "Returns whether Pac-Man has lost."
  @spec lose?(boolean(), boolean()) :: boolean()
  def lose?(power_pellet_active, touching_ghost) do
    touching_ghost and not power_pellet_active
  end

  @doc "Returns whether Pac-Man wins."
  @spec win?(boolean(), boolean(), boolean()) :: boolean()
  def win?(has_eaten_all_dots, power_pellet_active, touching_ghost) do
    has_eaten_all_dots and not lose?(power_pellet_active, touching_ghost)
  end
end
