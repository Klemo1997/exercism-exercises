defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @weekdays [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, schedule) do
    Date.new(year, month, 1)
    |> then(fn {:ok, date} -> Date.range(date, Date.end_of_month(date)) end)
    |> find_date(order(weekday), schedule)
  end

  defp find_date(days, weekday, :first), do: Enum.find(days, &(Date.day_of_week(&1) == weekday))
  defp find_date(days, weekday, :second), do: find_date(days, weekday, :first) |> Date.shift(week: 1)
  defp find_date(days, weekday, :third), do: find_date(days, weekday, :first) |> Date.shift(week: 2)
  defp find_date(days, weekday, :fourth), do: find_date(days, weekday, :first) |> Date.shift(week: 3)
  defp find_date(days, weekday, :last), do: Enum.reverse(days) |> find_date(weekday, :first)
  defp find_date(days, weekday, :teenth), do: Enum.find(days, fn %Date{day: day} = date -> Date.day_of_week(date) == weekday and day in 13..19 end)

  Enum.each(Enum.with_index(@weekdays, 1), fn {weekday, order} ->
    defp order(unquote(weekday)), do: unquote(order)
  end)
end