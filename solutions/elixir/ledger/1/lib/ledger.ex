defmodule Ledger do
  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(currency, locale, entries) do
    entries_with_header =
        sorted(entries)
        |> Enum.map(fn entry -> format_entry(currency, locale, entry) end)
        |> then(fn entries -> [header(locale) | entries] end)
        |> Enum.join("\n")

      entries_with_header <> "\n"
  end

  defp sorted(entries),
    do: Enum.sort(entries, fn a, b ->
          a.date.day < b.date.day
          || a.description < b.description
          || a.amount_in_cents <= b.amount_in_cents
        end)

  defp header(:en_US), do: "Date       | Description               | Change       "
  defp header(:nl_NL), do: "Datum      | Omschrijving              | Verandering  "

  defp format_entry(currency, locale, entry) do
    formatted_amount = format_number(entry.amount_in_cents, locale)
      |> amount(sign(currency), locale, entry.amount_in_cents >= 0)
      |> String.pad_leading(14, " ")

    date(entry.date, locale) <> " | " <> trim_description(entry.description) <> " |" <> formatted_amount
  end

  defp date(%Date{year: year, month: month, day: day}, :en_US), do: "#{format_day_or_month(month)}/#{format_day_or_month(day)}/#{format_year(year)}"
  defp date(%Date{year: year, month: month, day: day}, :nl_NL), do: "#{format_day_or_month(day)}-#{format_day_or_month(month)}-#{format_year(year)}"

  defp format_year(year), do: year |> to_string()
  defp format_day_or_month(day_or_month), do: day_or_month |> to_string() |> String.pad_leading(2, "0")

  defp trim_description(description) do
    case String.length(description) do
      len when len > 26 -> String.slice(description, 0, 22) <> "..."
      _ -> String.pad_trailing(description, 25, " ")
    end
  end

  defp format_number(cents, locale) do
    decimal = decimal(cents, 2)
    whole = whole(cents, 2, thousand_separator: thousand_separator(locale))
    whole <> decimal_separator(locale) <> decimal
  end

  defp decimal(cents, decimal_places),
    do: cents |> abs() |> rem(10 ** decimal_places) |> to_string() |> String.pad_leading(decimal_places, "0")

  defp whole(cents, decimal_places, options) do
    thousand_separator = Keyword.fetch!(options, :thousand_separator)
    without_cents = div(cents, 100) |> abs()

    if without_cents < 1000 do
      without_cents |> to_string()
    else
      thousands = div(without_cents, 1000)
      hundreds = rem(without_cents, 1000)
      to_string(thousands) <> thousand_separator <> to_string(hundreds)
    end
  end

  defp thousand_separator(:en_US), do: ","
  defp thousand_separator(:nl_NL), do: "."

  defp decimal_separator(:en_US), do: "."
  defp decimal_separator(:nl_NL), do: ","

  defp sign(:eur), do: "€"
  defp sign(:usd), do: "$"

  defp amount(number, sign, locale, non_negative?)
  defp amount(number, sign, :en_US, true), do: " #{sign}#{number} "
  defp amount(number, sign, :en_US, false), do: "(#{sign}#{number})"
  defp amount(number, sign, :nl_NL, true), do: "#{sign} #{number} "
  defp amount(number, sign, :nl_NL, false), do: "#{sign} -#{number} "
end
