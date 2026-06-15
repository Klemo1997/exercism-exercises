defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?("0"), do: false
  def valid?(number) do
    with {:ok, numbers} <- numbers(number),
      :ok <- (if numbers != [0], do: :ok, else: :error),
      sum <- sum(numbers),
      valid? <- rem(sum, 10) == 0 do
      valid?
    else
      :error -> false
    end
  end

  defp numbers(number, numbers \\ [])
  defp numbers(<<?\s, number::binary>>, numbers), do: numbers(number, numbers)
  defp numbers(<<d, number::binary>>, numbers) when d in ?0..?9, do: numbers(number, [d - ?0 | numbers])
  defp numbers(<<_, _::binary>>, _), do: :error
  defp numbers(<<>>, numbers), do: {:ok, numbers}

  defp sum(numbers, sum \\ 0)
  defp sum([a, b | numbers], sum) when b > 4, do: sum(numbers, sum + a + b*2 - 9)
  defp sum([a, b | numbers], sum), do: sum(numbers, sum + a + b*2)
  defp sum([a], sum), do: sum + a
  defp sum([], sum), do: sum
end
