defmodule Username do
  @spec sanitize(charlist()) :: charlist()
  def sanitize(''), do: ''

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
