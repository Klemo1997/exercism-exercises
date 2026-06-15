defmodule LanguageList do
  @moduledoc """
    Module containing functions to manipulate a list of programming languages.
  """
  @elixir "Elixir"

  @spec new() :: []
  def new(), do: []

  @spec add(list(string()), string()) :: nonempty_list(string())
  def add(list, language), do: [language | list]

  @spec remove([]) :: []
  def remove([]), do: []

  @spec remove(nonempty_list(string())) :: list(string())
  def remove([_ | list]), do: list

  @spec first([]) :: nil
  def first([]), do: nil

  @spec first(nonempty_list(string())) :: string()
  def first([head | tail]), do: head

  @spec count(list(string)) :: integer()
  def count(list), do: Enum.count(list)

  @spec functional_list?(list(string())) :: boolean()
  def functional_list?(list), do: Enum.any?(list, &(&1 === @elixir))
end
