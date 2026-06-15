defmodule LanguageList do
  @moduledoc """
    Module containing functions to manipulate a list of programming languages.
  """
  @elixir "Elixir"

  @spec new() :: []
  def new(), do: []

  @spec add(list(String.t()), String.t()) :: nonempty_list(String.t())
  def add(list, language), do: [language | list]

  @spec remove([]) :: []
  def remove([]), do: []

  @spec remove(nonempty_list(String.t())) :: list(String.t())
  def remove([_ | list]), do: list

  @spec first([]) :: nil
  def first([]), do: nil

  @spec first(nonempty_list(String.t())) :: String.t()
  def first([head | _]), do: head

  @spec count(list(String.t())) :: integer()
  def count(list), do: Enum.count(list)

  @spec functional_list?(list(String.t())) :: boolean()
  def functional_list?(list), do: Enum.any?(list, &(&1 === @elixir))
end
