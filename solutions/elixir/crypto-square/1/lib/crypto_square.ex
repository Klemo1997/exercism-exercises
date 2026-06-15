defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str),
    do: str
      |> normalize()
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.join(" ")

  defp normalize(str) when is_binary(str) do
    case String.replace(str, ~r/\W/, "") do
      "" -> []
      s -> 
        len = String.length(s)
        c = Enum.find(1..len, &(&1**2 >= len))
        String.to_charlist(String.downcase(s))
        |> Enum.chunk_every(c, c, String.to_charlist(String.duplicate(" ", c)))
    end
  end
end
