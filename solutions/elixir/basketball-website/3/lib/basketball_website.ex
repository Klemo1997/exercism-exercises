defmodule BasketballWebsite do
  @spec extract_from_path(map(), String.t()) :: any()
  def extract_from_path(data, path) do
    do_extract_from_path(data, String.split(path, "."))
  end

  @spec do_extract_from_path(map()|nil, list(String.t())) :: any()
  defp do_extract_from_path(nil, _), do: nil
  defp do_extract_from_path(data, []), do: data
  defp do_extract_from_path(data, [key | rest]), 
    do: do_extract_from_path(data[key], rest)

  def get_in_path(data, path), 
    do: get_in(data, String.split(path, "."))
end
