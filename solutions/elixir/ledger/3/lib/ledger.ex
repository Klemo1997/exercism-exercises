defmodule Ledger do
  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @date_cell_width 10
  @description_cell_width 25
  @change_cell_width 13

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
    do: Enum.sort_by(entries, &{&1.date.day, &1.description, &1.amount_in_cents})

  defp header(:en_US), do: line(["Date", "Description", "Change"])
  defp header(:nl_NL), do: line(["Datum", "Omschrijving", "Verandering"])

  defp line([date, description, change]),
    do: [
          cell(date, @date_cell_width),
          cell(description, @description_cell_width),
          cell(change, @change_cell_width)
        ]
      |> Enum.join(" | ")

  defp cell(content, width) do
    cond do
      String.length(content) <= width -> String.pad_trailing(content, width)
      true -> String.slice(content, 0, width-3) <> "..."
    end
  end

  defp format_entry(currency, locale, entry) do
    date = cell(format_date(entry.date, locale), 10)
    description = entry.description
    change = format_number(entry.amount_in_cents, locale)
      |> format_money(currency, locale, entry.amount_in_cents >= 0)

    line([date, description, change |> String.pad_leading(@change_cell_width)])
  end

  defp format_date(date, :en_US),
    do: :io_lib.format("~2..0B/~2..0B/~4..0B", [date.month, date.day, date.year]) |> to_string()
  defp format_date(date, :nl_NL),
    do: :io_lib.format("~2..0B-~2..0B-~4..0B", [date.day, date.month, date.year]) |> to_string()

  defp format_number(cents, locale) when is_integer(cents) do
    decimal = rem(abs(cents), 100)
    whole = div(abs(cents), 100)
    hundreds = rem(whole, 1000)
    thousands = div(whole, 1000)
    format_number({thousands, hundreds, decimal}, locale)
  end

  defp format_number({0, hundreds, cents}, :en_US),
    do: :io_lib.format("~p.~2..0B", [hundreds, cents]) |> to_string()
  defp format_number({thousands, hundreds, cents}, :en_US),
    do: :io_lib.format("~p,~3..0B.~2..0B", [thousands, hundreds, cents]) |> to_string()
  defp format_number({0, hundreds, cents}, :nl_NL),
    do: :io_lib.format("~p,~2..0B", [hundreds, cents]) |> to_string()
  defp format_number({thousands, hundreds, cents}, :nl_NL),
    do: :io_lib.format("~p.~3..0B,~2..0B", [thousands, hundreds, cents]) |> to_string()

  defp format_money(number, :usd, :en_US, true), do: "$#{number} "
  defp format_money(number, :eur, :en_US, true), do: "€#{number} "
  defp format_money(number, :usd, :en_US, false), do: "($#{number})"
  defp format_money(number, :eur, :en_US, false), do: "(€#{number})"
  defp format_money(number, :usd, :nl_NL, true), do: "$ #{number} "
  defp format_money(number, :eur, :nl_NL, true), do: "€ #{number} "
  defp format_money(number, :usd, :nl_NL, false), do: "$ -#{number} "
  defp format_money(number, :eur, :nl_NL, false), do: "€ -#{number} "
end
