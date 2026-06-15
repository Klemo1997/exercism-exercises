defmodule Frequency do
  @forbidden_chars Enum.to_list(0..127) -- Enum.to_list(?a..?z)

  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers),
    do: texts
      |> Task.async_stream(&letter_frequency/1, max_concurrency: workers)
      |> Enum.reduce(%{}, fn {:ok, current_freq}, freq -> 
          Map.merge(current_freq, freq, fn _k, v1, v2 -> v1 + v2 end) 
        end)

  defp letter_frequency(text), 
    do: text
      |> String.downcase()
      |> String.graphemes()
      |> Enum.filter(fn <<c::utf8, _::binary>> -> c not in @forbidden_chars end)
      |> Enum.frequencies()
end
