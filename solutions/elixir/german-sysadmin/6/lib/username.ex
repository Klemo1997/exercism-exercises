defmodule Username do
  @moduledoc """
  Module containing username sanitization.
  """

  @spec lowercase?(char()) :: boolean()
  defguardp lowercase?(c) when c >= ?a and c <= ?z

  @spec is_german?(char()) :: boolean()
  defguardp is_german?(c) when c in ~c"äöüß"

  @spec sanitize(charlist()) :: charlist()
  def sanitize(~c""), do: ~c""
  def sanitize([char | tail]) when is_german?(char), do: sanitize_german_char(char) ++ sanitize(tail)
  def sanitize([char | tail]) when lowercase?(char) or char === ?_, do: [char | sanitize(tail)]
  def sanitize([_ | tail]), do: sanitize(tail)

  @spec sanitize_german_char(char()) :: nonempty_charlist()
  defp sanitize_german_char(char) do
    case char do
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      other -> [other]
    end
  end
end
