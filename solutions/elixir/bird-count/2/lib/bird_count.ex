defmodule BirdCount do
  @moduledoc """
    Module for tracking and processing bird watching data
  """
  @initial_day_count [1]

  @type integer_list() :: list(integer())

  @spec today(integer_list()) :: integer() | nil
  def today([]), do: nil

  def today([head | _]), do: head

  @spec increment_day_count(integer_list()) :: integer_list()
  def increment_day_count([]), do: @initial_day_count

  def increment_day_count([head | tail]) do 
    [head + 1 | tail]
  end

  @spec has_day_without_birds?(integer_list()) :: boolean()
  def has_day_without_birds?([]), do: false

  def has_day_without_birds?([0 | _]), do: true

  def has_day_without_birds?([_ | tail]), do: has_day_without_birds?(tail)


  @spec total(integer_list()) :: integer()
  def total([]), do: 0

  def total([head | tail]) do
    head + total(tail)
  end

  @spec busy_days(integer_list()) :: integer()
  def busy_days([]), do: 0

  def busy_days([head | tail]) when head >= 5 do
    1 + busy_days(tail)
  end

  def busy_days([_ | tail]) do
    busy_days(tail)
  end
end