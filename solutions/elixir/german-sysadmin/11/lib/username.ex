defmodule Username do
  @moduledoc """
  Module containing username sanitization.
  """

  @spec sanitize(charlist()) :: charlist()
  def sanitize(username), do: sanitize(username, [])
  
  defp sanitize([?ä | rest], sanitized), do: sanitize(rest, [?e, ?a | sanitized])
  defp sanitize([?ö | rest], sanitized), do: sanitize(rest, [?e, ?o | sanitized])
  defp sanitize([?ü | rest], sanitized), do: sanitize(rest, [?e, ?u | sanitized])
  defp sanitize([?ß | rest], sanitized), do: sanitize(rest, [?s, ?s | sanitized])
  defp sanitize([?_ | rest], sanitized), do: sanitize(rest, [?_ | sanitized])
  defp sanitize([l | rest], sanitized) when l in ?a..?z, do: sanitize(rest, [l | sanitized])
  defp sanitize([_ | rest], sanitized), do: sanitize(rest, sanitized)
  defp sanitize([], sanitized), do: Enum.reverse(sanitized)
end
