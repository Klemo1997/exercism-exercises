defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    digits_count = Enum.count(digits)
    number === Enum.reduce(digits, 0, fn digit, acc -> acc + (digit ** digits_count) end)
  end
end
