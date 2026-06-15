defmodule Lasagna do
  @moduledoc """
    Module for making tasteful lasagna.
  """

  @doc """
    Returns how many minutes the lasagna is in the oven.
  """
  @spec expected_minutes_in_oven() :: integer()
  def expected_minutes_in_oven(), do: 40

  @doc """
    Takes the actual minutes the lasagna has been in the oven 
    as an argument and returns how many minutes the lasagna
    still has to remain in the oven.
  """
  @spec remaining_minutes_in_oven(integer()) :: integer()
  def remaining_minutes_in_oven(time_spent), do: expected_minutes_in_oven() - time_spent

  @doc """
    Takes the number of layers you added to the lasagna 
    as an argument and returns how many minutes you spent 
    preparing the lasagna.
  """
  @spec preparation_time_in_minutes(integer()) :: integer()
  def preparation_time_in_minutes(layers_count), do: layers_count * 2

  @doc """
    Takes two arguments: the first argument is the 
    number of layers you added to the lasagna, and 
    the second argument is the number of minutes the 
    lasagna has been in the oven.
    The function returns how many minutes in 
    total you've worked on cooking the lasagna.
  """
  @spec total_time_in_minutes(integer(), integer()) :: integer()
  def total_time_in_minutes(layers_count, time_spent), do: 
     preparation_time_in_minutes(layers_count) + time_spent

  @doc """
    Returns a message indicating that the lasagna is ready to eat.
  """
  @spec alarm() :: String.t()
  def alarm(), do: "Ding!"
end
