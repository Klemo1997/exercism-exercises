defmodule WineCellar do
  @type wine() :: {grape :: String.t(), year :: pos_integer(), country :: String.t()}

  @spec explain_colors() :: keyword(String.t())
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  @spec filter(keyword(wine()), atom(), keyword()) :: list(wine())
  def filter(cellar, color, opts \\ []) do
    Keyword.get_values(cellar, color)
      |> maybe_filter(opts[:year], &filter_by_year/2)
      |> maybe_filter(opts[:country], &filter_by_country/2)
  end

  @spec maybe_filter(list(wine()), any(), (list(wine()), any() -> boolean())) :: list(wine())
  defp maybe_filter(wines, nil, _), do: wines

  defp maybe_filter(wines, value, predicate), do: predicate.(wines, value)

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
