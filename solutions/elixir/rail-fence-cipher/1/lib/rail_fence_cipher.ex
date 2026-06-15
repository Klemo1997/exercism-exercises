defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(str, rails) do
    cycle = rails_cycle(rails)
    graphemes = String.graphemes(str)
    for rail <- 1..rails, {^rail, letter} <- Enum.zip(cycle, graphemes), into: "" do
      letter
    end
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, rails) do
    cycle = rails_cycle(rails)
    graphemes = String.graphemes(str)
    for(rail <- 1..rails, {^rail, index} <- Enum.zip(cycle, 0..String.length(str)-1),
      do: index)
    |> Enum.zip(graphemes)
    |> Enum.sort()
    |> Enum.map_join(&elem(&1, 1))
  end

  defp rails_cycle(rails) when rails <= 2, do: Stream.cycle(1..rails)
  defp rails_cycle(rails), do: Stream.concat(1..rails, rails-1..2) |> Stream.cycle()
end
