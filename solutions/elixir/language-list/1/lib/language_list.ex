defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove(list) do
    list |> Kernel.tl()
  end

  def first(list) do
    list |> Kernel.hd()
  end

  def count(list) do
    list |> Kernel.length()
  end

  def functional_list?(list) do
    "Elixir" in list
  end
end
