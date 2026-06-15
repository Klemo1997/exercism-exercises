defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    recursive_extract(data, String.split(path, "."))
  end

  defp recursive_extract(data, [key | rest]), do:
    recursive_extract(data[key], rest)

  defp recursive_extract(nil, path), do: nil
  defp recursive_extract(data, []), do: data

  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end
