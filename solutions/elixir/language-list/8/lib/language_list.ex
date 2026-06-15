defmodule LanguageList do
  @moduledoc """
    Module containing functions to manipulate a list of programming languages.
  """
  @elixir "Elixir"

  @spec new() :: []
  def new(), do: []

  @spec add(list(String.t()), String.t()) :: nonempty_list(String.t())
  def add(list, language), do: [language | list]

  @spec remove(nonempty_list(String.t())) :: list(String.t())
  def remove([_ | list]), do: list

  @spec first(list(String.t())) :: String.t()|nil
  def first(list), do: List.first(list)

  @spec count(list(String.t())) :: integer()
  def count(list), do: length(list)

  @spec functional_list?(list(String.t())) :: boolean()
  def functional_list?(list), do: @elixir in list
end
