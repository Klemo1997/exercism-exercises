defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  @error_message "count must be specified as an integer >= 1"
  @initial_sequence {-1, 2}

  def generate(count) when not is_integer(count) or count < 1, do: raise ArgumentError, @error_message
  def generate(count) do
    Stream.iterate(@initial_sequence, fn {a, b} -> {b, a + b} end)
    |> Stream.map(fn {_, b} -> b end)
    |> Enum.take(count)
  end
end
