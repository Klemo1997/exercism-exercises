defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @number_to_word %{
    3 => "Pling",
    5 => "Plang",
    7 => "Plong",
  }

  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    Map.keys(@number_to_word)
    |> Enum.filter(&(rem(number,&1) === 0))
    |> Enum.map(&(@number_to_word[&1]))
    |> format(number)
  end

  @spec 
  defp format([], number), do: Integer.to_string(number)
  defp format(words, _), do: Enum.join(words)
end
