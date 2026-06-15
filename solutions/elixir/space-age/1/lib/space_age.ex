defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @planets_and_periods [
    {:mercury, 0.2408467},
    {:venus, 0.61519726},
    {:earth, 1},
    {:mars, 1.8808158},
    {:jupiter, 11.862615},
    {:saturn, 29.447498},
    {:uranus, 84.016846},
    {:neptune, 164.79132},
  ]

  @earth_period_seconds 31_557_600

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  Enum.each(@planets_and_periods, fn {planet, ratio} -> 
    def age_on(unquote(planet), seconds), do: {:ok, seconds / @earth_period_seconds / unquote(ratio)}
  end)
  def age_on(_invalid_planet, _), do: {:error, "not a planet"}
end
