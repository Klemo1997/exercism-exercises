defmodule House do
  @starting_verses {
    "This is the house that Jack built.",
    "This is the malt",
    "This is the rat",
    "This is the cat",
    "This is the dog",
    "This is the cow with the crumpled horn",
    "This is the maiden all forlorn",
    "This is the man all tattered and torn",
    "This is the priest all shaven and shorn",
    "This is the rooster that crowed in the morn",
    "This is the farmer sowing his corn",
    "This is the horse and the hound and the horn",
  }

  @verses {
    "that lay in the house that Jack built.",
    "that ate the malt",
    "that killed the rat",
    "that worried the cat",
    "that tossed the dog",
    "that milked the cow with the crumpled horn",
    "that kissed the maiden all forlorn",
    "that married the man all tattered and torn",
    "that woke the priest all shaven and shorn",
    "that kept the rooster that crowed in the morn",
    "that belonged to the farmer sowing his corn",
  }

  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop), do: Enum.map(start..stop, &verse(&1)) |> Enum.join("\n") |> then(fn verses -> verses <> "\n" end)

  defp verse(number, rows \\ [])
  defp verse(0, rows), do: Enum.reverse(rows) |> Enum.join(" ")
  defp verse(number, []), do: verse(number-1, [elem(@starting_verses, number-1)])
  defp verse(number, rows), do: verse(number-1, [elem(@verses, number-1) | rows])
end