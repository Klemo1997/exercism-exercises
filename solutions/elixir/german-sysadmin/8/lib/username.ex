defmodule Username do
  @moduledoc """
  Module containing username sanitization.
  """

  @spec lowercase?(char()) :: boolean()
  defguardp lowercase?(c) when c >= ?a and c <= ?z

  @spec sanitize(charlist()) :: charlist()
  def sanitize(~c""), do: ~c""
  def sanitize([char | tail]) do
    sanitized_char = case char do
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      it when lowercase?(it) or it === ?_ -> [it]
      _ -> ~c""
    end
    sanitized_char ++ sanitize(tail)
  end
end
