defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    %Clock{hour: normalize(:hours, hour + floor(minute / 60)), minute: normalize(:minutes, minute)}
  end

  defp normalize(:hours, hours), do: rem(24 + rem(hours, 24), 24)
  defp normalize(:minutes, minutes), do: rem(60 + rem(minutes, 60), 60)

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    new(hour, minute + add_minute)
  end
end

defimpl String.Chars, for: Clock do
  def to_string(%Clock{hour: hour, minute: minute}) do
    "#{pad_time(hour)}:#{pad_time(minute)}"
  end 

  defp pad_time(minute_or_hour), do: String.pad_leading(Kernel.to_string(minute_or_hour), 2, "0")
end