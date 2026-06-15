defmodule Username do
  @spec sanitize(charlist()) :: charlist()
  def sanitize(''), do: ''

#    username |> Enum.filter(&char_valid?/1)
#    # ä becomes ae
#    # ö becomes oe
#    # ü becomes ue
#    # ß becomes ss
#
#    # Please implement the sanitize/1 function
#  end
#
#  @spec char_valid?(pos_integer()) :: boolean()
#  defp char_valid?(char) do
#    case char do
#      ?_ -> true
#      char when 97 <= char and char <= 122 -> true
#      _ -> false
#    end
#  end
#
#  defp
  def sanitize([head | tail]) do
    sanitized_charlist = case head do
      c when ?a <= c and c <= ?z -> [c]
      ?_ -> '_'
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      _ -> ''
    end

    sanitized_charlist ++ sanitize(tail)
  end
end
