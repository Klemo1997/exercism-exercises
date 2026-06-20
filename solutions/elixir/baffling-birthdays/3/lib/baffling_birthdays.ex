defmodule BafflingBirthdays do
  @moduledoc """
  Estimate the probability of shared birthdays in a group of people.
  """

  @spec shared_birthday?(birthdates :: [Date.t()]) :: boolean()
  def shared_birthday?(birthdates), do: shared_birthday?(birthdates, MapSet.new())
  defp shared_birthday?([bday | bdays], used_bdays) do
    date_without_year = date_without_year(bday)
    if MapSet.member?(used_bdays, date_without_year) do
      true
    else
      shared_birthday?(bdays, MapSet.put(used_bdays, date_without_year))
    end
  end
  defp shared_birthday?([], _), do: false

  defp date_without_year(date), do: {date.month, date.day}

  @spec random_birthdates(group_size :: integer()) :: [Date.t()]
  def random_birthdates(group_size) do
    Stream.repeatedly(&random_date_without_leap_years/0)
    |> Enum.take(group_size)
  end

  defp random_date_without_leap_years() do
    year = Enum.random(1900..2026)
    month = Enum.random(1..12)
    day = Enum.random(1..31)
    case Date.new(year, month, day) do
      {:ok, date} -> if Date.leap_year?(date), do: random_date_without_leap_years(), else: date
      {:error, _} -> random_date_without_leap_years()
    end
  end

  @spec estimated_probability_of_shared_birthday(group_size :: integer()) :: float()
  def estimated_probability_of_shared_birthday(group_size) when group_size > 365, do: 1.0
  def estimated_probability_of_shared_birthday(group_size),
    do: 100 * (1.0 - for(i <- 0..(group_size-1), reduce: 1.0, do: (p_unique -> p_unique * (365 - i) / 365)))
end
