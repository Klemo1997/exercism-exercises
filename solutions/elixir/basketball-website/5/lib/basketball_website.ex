defmodule BasketballWebsite do
  @spec tokenize(String.t()) :: list(String.t())
  defp tokenize(path), do: String.split(path, ".")

  @spec extract_from_path(map(), String.t()) :: any()
  def extract_from_path(data, path), 
    do: do_extract_from_path(data, tokenize(path))

  @spec do_extract_from_path(map()|nil, list(String.t())) :: any()
  defp do_extract_from_path(nil, _), do: nil
  defp do_extract_from_path(data, []), do: data
  defp do_extract_from_path(data, [key | rest]), 
    do: do_extract_from_path(data[key], rest)

  @spec get_in_path(map(), String.t()) :: any()
  def get_in_path(data, path), 
    do: get_in(data, tokenize(path))
end
