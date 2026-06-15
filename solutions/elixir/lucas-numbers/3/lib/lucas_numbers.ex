defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  @error_message "count must be specified as an integer >= 1"
  @initial_sequence {2, 1}

  def generate(count) when is_integer(count) and count >= 1, do:
    Stream.unfold(@initial_sequence, fn {current, next} -> {current, {next, current + next}} end)
    |> Enum.take(count)
  def generate(_), do: (raise ArgumentError, @error_message)
end
