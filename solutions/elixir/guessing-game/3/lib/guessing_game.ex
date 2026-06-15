defmodule GuessingGame do
  @moduledoc """
    Module containing a guessing game.
  """
  @spec compare(number(), number() | :no_guess) :: String.t()
  def compare(secret_number, guess \\ :no_guess)

  def compare(_, :no_guess), do: "Make a guess"

  def compare(secret_number, guess) when secret_number === guess, do: "Correct"

  def compare(secret_number, guess) when abs(secret_number - guess) === 1, do: "So close"

  def compare(secret_number, guess) when secret_number < guess, do: "Too high"

  def compare(secret_number, guess) when secret_number > guess, do: "Too low"
end
