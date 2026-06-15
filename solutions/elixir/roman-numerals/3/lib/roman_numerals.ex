defmodule RomanNumerals do
  @numbers_and_numerals [
    {1000, ~c(M)},
    {900, ~c(CM)},
    {500, ~c(D)},
    {400, ~c(CD)},
    {100, ~c(C)},
    {90, ~c(XC)},
    {50, ~c(L)},
    {40, ~c(XL)},
    {10, ~c(X)},
    {9, ~c(IX)},
    {5, ~c(V)},
    {4, ~c(IV)},
    {1, ~c(I)},
  ]

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
  Enum.each(@numbers_and_numerals, fn
    {n, [prefix, code]} -> 
      defp numeral(number, numeral) when number >= unquote(n), do: numeral(number - unquote(n), [unquote(code), unquote(prefix) | numeral])
    {n, [code]} ->
      defp numeral(number, numeral) when number >= unquote(n), do: numeral(number - unquote(n), [unquote(code) | numeral])
  end)
end
