defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @word_conversion_map %{
    3 => "Pling",
    5 => "Plang",
    7 => "Plong",
  }

  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    result = 3..7//2
    |> Enum.map(&(maybe_string(@word_conversion_map[&1], rem(number, &1) === 0)))
    |> Enum.join

    if result !== "", do: result, else: Integer.to_string(number)
  end

  defp maybe_string(_, false), do: ""
  defp maybe_string(string, _), do: string
end
