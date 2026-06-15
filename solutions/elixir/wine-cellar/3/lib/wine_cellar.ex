defmodule WineCellar do
  @moduledoc """
  Module for filtering wines by various properties.
  """

  @type wine_props() :: {grape :: String.t(), year :: pos_integer(), country :: String.t()}
  @type wine() :: {atom(), wine_props()}

  @spec explain_colors() :: keyword(String.t())
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine.",
    ]
  end

  @spec filter(keyword(wine_props()), atom(), keyword()) :: list(wine())
  def filter(wine_list, color, options \\ []) do
    Enum.flat_map(wine_list, 
      fn wine -> 
        wine
        |> filter_by_color(color) 
        |> filter_by_year(options[:year])
        |> filter_by_country(options[:country])
        |> transform
      end
    )
  end

  @spec transform(wine() | nil) :: [wine_props()] | []
  defp transform(nil), do: []

  defp transform({_color, wine}), do: [wine]

  @spec filter_by_color(wine() | nil, atom()) :: wine() | nil
  defp filter_by_color(wine = {color, _properties}, wanted_color) do
    if wanted_color === nil or color === wanted_color, do: wine, else: nil
  end

  @spec filter_by_year(wine() | nil, pos_integer() | nil) :: wine() | nil
  defp filter_by_year(nil, _), do: nil

  defp filter_by_year(wine = {_color, {_name, year, _country}}, wanted_year) do
    if wanted_year === nil or year === wanted_year, do: wine, else: nil
  end

  @spec filter_by_country(wine() | nil, String.t() | nil) :: wine() | nil
  defp filter_by_country(nil, _), do: nil

  defp filter_by_country(wine = {_color, {_name, _year, country}}, wanted_country) do
    if wanted_country === nil or country === wanted_country, do: wine, else: nil
  end
end
