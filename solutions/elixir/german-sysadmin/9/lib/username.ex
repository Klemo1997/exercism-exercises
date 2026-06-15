defmodule Username do
  @moduledoc """
  Module containing username sanitization.
  """

  @spec sanitize(charlist()) :: charlist()
  def sanitize(username, sanitized \\ [])
  def sanitize([?ä | rest], sanitized), do: sanitize(rest, [?e, ?a | sanitized])
  def sanitize([?ö | rest], sanitized), do: sanitize(rest, [?e, ?o | sanitized])
  def sanitize([?ü | rest], sanitized), do: sanitize(rest, [?e, ?u | sanitized])
  def sanitize([?ß | rest], sanitized), do: sanitize(rest, [?s, ?s | sanitized])
  def sanitize([?_ | rest], sanitized), do: sanitize(rest, [?_ | sanitized])
  def sanitize([l | rest], sanitized) when l in ?a..?z, do: sanitize(rest, [l | sanitized])
  def sanitize([_ | rest], sanitized), do: sanitize(rest, sanitized)
  def sanitize([], sanitized), do: Enum.reverse(sanitized)
end
