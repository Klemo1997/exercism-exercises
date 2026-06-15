defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    numeral(number, [])
    |> Enum.reverse()
    |> IO.iodata_to_binary()
  end

  defp numeral(0, numeral), do: numeral
  defp numeral(number, numeral) when number >= 1000, do: numeral(number - 1000, [?M | numeral])
  defp numeral(number, numeral) when number >= 900, do: numeral(number - 900, [?M, ?C | numeral])
  defp numeral(number, numeral) when number >= 500, do: numeral(number - 500, [?D | numeral])
  defp numeral(number, numeral) when number >= 400, do: numeral(number - 400, [?D, ?C | numeral])
  defp numeral(number, numeral) when number >= 100, do: numeral(number - 100, [?C | numeral])
  defp numeral(number, numeral) when number >= 90, do: numeral(number -  90, [?C, ?X | numeral])
  defp numeral(number, numeral) when number >= 50, do: numeral(number -  50, [?L | numeral])
  defp numeral(number, numeral) when number >= 40, do: numeral(number -  40, [?L, ?X | numeral])
  defp numeral(number, numeral) when number >= 10, do: numeral(number -  10, [?X | numeral])
  defp numeral(number, numeral) when number >= 9, do: numeral(number -  9, [?X, ?I | numeral])
  defp numeral(number, numeral) when number >= 5, do: numeral(number -  5, [?V | numeral])
  defp numeral(number, numeral) when number >= 4, do: numeral(number -  4, [?V, ?I | numeral])
  defp numeral(number, numeral) when number >= 1, do: numeral(number -  1, [?I | numeral])
end
