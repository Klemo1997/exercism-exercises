defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """
  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, input_base, output_base) when input_base < 2 or output_base < 2 do
    if output_base < 2 do
      {:error, "output base must be >= 2"}
    else
      {:error, "input base must be >= 2"}
    end
  end

  def convert([], _, _) do
    {:ok, [0]}
  end

  def convert(digits, input_base, output_base) do
    try do
      num = get_base_10_value(Enum.reverse(digits), input_base)
      base_output = if num > 0, do: Enum.reverse(get_from_base_10_value(num, output_base)), else: [0]

      {:ok, base_output}
    rescue
      err in ArgumentError -> {:error, err.message}
    end
  end

  @spec get_base_10_value(list, integer) :: integer
  defp get_base_10_value(digits, base, i \\ 0)

  defp get_base_10_value([], _, _), do: 0

  defp get_base_10_value([multiplier | rest], base, i) do
      if multiplier < 0 or multiplier >= base do
        raise(ArgumentError, "all digits must be >= 0 and < input base")
      end

      multiplier * Integer.pow(base, i) + get_base_10_value(rest, base, i + 1)
  end

  @spec get_from_base_10_value(integer, integer) :: list(integer)
  defp get_from_base_10_value(0, _), do: []

  defp get_from_base_10_value(acc, base) do
    res = Kernel.rem(acc, base)
    new_acc = Kernel.div(acc, base)

    [res | get_from_base_10_value(new_acc, base)]
  end
end
