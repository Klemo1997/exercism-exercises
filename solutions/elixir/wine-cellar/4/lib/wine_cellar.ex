defmodule WineCellar do
  @moduledoc """
  Module for filtering wines by various properties.
  """

  @type wine() :: {grape :: String.t(), year :: pos_integer(), country :: String.t()}

  @spec explain_colors() :: keyword(String.t())
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine.",
    ]
  end

  @spec filter(keyword(wine()), atom(), keyword()) :: list(wine())
  def filter(wines, color, options \\ []) do
    year = Keyword.get(options, :year)
    country = Keyword.get(options, :country)
    wines
      |> Keyword.get_values(color)
      |> Enum.filter(&(filter_by_year(&1, year) and filter_by_country(&1, country)))
  end

  @spec filter_by_year(wine(), pos_integer()) :: boolean()
  defp filter_by_year(_wine, nil), do: true
  defp filter_by_year({_name, year, _country}, wanted_year), do: year === wanted_year

  @spec filter_by_country(wine(), String.t()) :: boolean()
  defp filter_by_country(_wine, nil), do: true
  defp filter_by_country({_name, _year, country}, wanted_country), do: country === wanted_country
end
