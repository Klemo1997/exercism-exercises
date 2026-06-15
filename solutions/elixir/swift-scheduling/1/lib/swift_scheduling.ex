defmodule SwiftScheduling do
  @doc """
  Convert delivery date descriptions to actual delivery dates, based on when the meeting started.
  """
  @spec delivery_date(NaiveDateTime.t(), String.t()) :: NaiveDateTime.t()
  def delivery_date(%NaiveDateTime{} = meeting_date, "NOW"), do: NaiveDateTime.add(meeting_date, 2, :hour)

  def delivery_date(%NaiveDateTime{} = meeting_date, "ASAP") when meeting_date.hour < 13,
    do: %{meeting_date | hour: 17, minute: 0, second: 0}
  def delivery_date(%NaiveDateTime{} = meeting_date, "ASAP"),
    do: %{meeting_date | hour: 13, minute: 0, second: 0}
      |> NaiveDateTime.add(1, :day)
  def delivery_date(%NaiveDateTime{} = meeting_date, "EOW") do
    case Date.day_of_week(meeting_date) do
      weekday when weekday < 4 ->
        %{meeting_date | hour: 17, minute: 0, second: 0}
        |> NaiveDateTime.add(5 - weekday, :day)
      weekday ->
        %{meeting_date | hour: 20, minute: 0, second: 0}
        |> NaiveDateTime.add(7 - weekday, :day)
    end
  end
  def delivery_date(%NaiveDateTime{} = meeting_date, description) do
    cond do
      String.match?(description, ~r/\d+M/) ->
        {month, "M"} = Integer.parse(description)
        nth_month(meeting_date, month)
      String.match?(description, ~r/Q\d/) ->
        "Q" <> quarter = description
        nth_quarter(meeting_date, String.to_integer(quarter))
    end
  end

  defp nth_month(date, month) when month in 1..12 do
    before_date? = date.month < month

    nth_month_date = %{date | month: month}

    new_date = if before_date? do
      first_month_workday(nth_month_date)
    else
      NaiveDateTime.shift(nth_month_date, year: 1)
      |> first_month_workday()
    end

    NaiveDateTime.new!(new_date, ~T[08:00:00])
  end

  defp nth_quarter(date, quarter) when quarter in 1..4 do
    schedule_this_year? = date.month < quarter * 3

    quarter_last_month = %{date | month: quarter * 3}

    new_date = if schedule_this_year? do
      last_month_workday(quarter_last_month)
    else
      NaiveDateTime.shift(quarter_last_month, year: 1)
      |> last_month_workday()
    end

    NaiveDateTime.new!(new_date, ~T[08:00:00])
  end

  defp first_month_workday(date) do
    first_month_day = Date.beginning_of_month(date)

    case Date.day_of_week(first_month_day) do
      weekday when weekday in 1..5 -> first_month_day
      6 = _saturday -> Date.add(first_month_day, 2)
      7 = _sunday -> Date.add(first_month_day, 1)
    end
  end

  defp last_month_workday(date) do
    last_month_day = Date.end_of_month(date)

    case Date.day_of_week(last_month_day) do
      weekday when weekday in 1..5 -> last_month_day
      6 = _saturday -> Date.add(last_month_day, -1)
      7 = _sunday -> Date.add(last_month_day, -2)
    end
  end
end
