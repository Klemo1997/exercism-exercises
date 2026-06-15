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
    sanitized_head = case head do
      head when ?a <= head and head <= ?z -> [head]
      ?_ -> [?_]
      ?ä -> [?a, ?e]
      ?ö -> [?o, ?e]
      ?ü -> [?u, ?e]
      ?ß -> [?s, ?s]
      _ -> []
    end

    sanitized_head ++ sanitize(tail)
  end
end
