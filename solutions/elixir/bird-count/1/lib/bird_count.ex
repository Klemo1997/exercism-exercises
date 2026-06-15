defmodule BirdCount do
  @moduledoc """
    Bird counting logics...
  """
  def today(list), do:
    list
    |> List.first

  def increment_day_count([]), do: [1]

  def increment_day_count(list) do
    [head | tail] = list

    [head + 1 | tail]
  end

  def has_day_without_birds?([]), do: false

  def has_day_without_birds?(list) do
    list
    |> Enum.any?(&(&1 == 0))
  end

  def total([]), do: 0

  def total(list) do
     Enum.sum(list)
  end

  def busy_days([]), do: 0

  def busy_days(list) do
    list
    |> Enum.filter(&(&1 >= 5))
    |> Enum.count
  end
end
