defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    suffix = 1000..9999
    |> Enum.random

    "NCC-#{suffix}"
  end

  def random_stardate() do
    (:rand.uniform() * 1000) + 41000.0
  end

  def format_stardate(stardate) do
    formatted_date = :io_lib.format("~.1f", [stardate])
    List.to_string(formatted_date)
  end
end
