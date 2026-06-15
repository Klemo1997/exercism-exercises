defmodule Diamond do
  @doc """
   This generates a sequence that is defined by number of spaces inside of diamond
   for given letter (zero-indexed, but we omit "A", because it produces a spec-case, so this starts from letter "B")
  """
  @letter_sizes Enum.to_list(1..49//2)

  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(letter) when letter in ?A..?Z, 
    do: letter..?A
      |> Enum.with_index()
      |> Enum.reverse()
      |> mirror()
      |> Enum.map(fn {letter, padding} -> 
        pad = String.duplicate(" ", padding)
        pad <> diamond(letter) <> pad <> "\n"
      end)
      |> Enum.join()

  def diamond(?A), do: "A"
  Enum.each(Enum.with_index(@letter_sizes, 1), fn {size, letter_index} ->
    letter = ?A + letter_index
    def diamond(unquote(letter)), 
      do: <<unquote(letter), String.duplicate(" ", unquote(size))::binary, unquote(letter)>>
  end)

  defp mirror(list) do
    [_ | reversed] = Enum.reverse(list)
    list ++ reversed
  end
end
