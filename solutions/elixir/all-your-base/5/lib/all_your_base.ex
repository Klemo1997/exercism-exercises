defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """
  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}
  def convert([], _, _), do: {:ok, [0]}

  def convert(digits, input_base, output_base) do
    if Enum.any?(digits, &digit_invalid?(&1, input_base)) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      {:ok, do_convert(digits, input_base, output_base)}
    end
  end

  defp do_convert(digits, input_base, output_base) do
    num = to_decimal(Enum.reverse(digits), input_base, 0)
    if num > 0, do: Enum.reverse(from_decimal(num, output_base)), else: [0]
  end

  @spec to_decimal(list, integer, integer) :: integer
  defp to_decimal([], _, _), do: 0

  defp to_decimal([multiplier | rest], base, i) do
    multiplier * Integer.pow(base, i) + to_decimal(rest, base, i + 1)
  end

  @spec from_decimal(integer, integer) :: list(integer)
  defp from_decimal(0, _), do: []

  defp from_decimal(acc, base) do
    res = Kernel.rem(acc, base)
    new_acc = Kernel.div(acc, base)

    [res | from_decimal(new_acc, base)]
  end

  @spec digit_invalid?(integer, integer):: boolean
  defp digit_invalid?(n, base), do: n < 0 or n >= base
end
