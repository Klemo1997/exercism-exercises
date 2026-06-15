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
    digits
    |> to_decimal(input_base, 0)
    |> from_decimal(output_base, [])
  end

  @spec to_decimal(list, integer, integer) :: integer
  defp to_decimal([], _, acc), do: acc

  defp to_decimal([digit | rest], base, acc) do
    new_acc = acc * base + digit
    to_decimal(rest, base, new_acc)
  end

  @spec from_decimal(integer, integer, list(integer)) :: list(integer)
  defp from_decimal(n, base, acc) when n < base, do: [n | acc]

  defp from_decimal(n, base, acc) do
    rem = Kernel.rem(n, base)
    new_acc = Kernel.div(n, base)

    from_decimal(new_acc, base, [rem | acc])
  end

  @spec digit_invalid?(integer, integer):: boolean
  defp digit_invalid?(n, base), do: n < 0 or n >= base
end
