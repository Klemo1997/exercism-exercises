defmodule LibraryFees do
  @time_noon ~T[12:00:00]
  @before_noon_due_days 28
  @after_noon_due_days 29
  @monday 1

  @spec datetime_from_string(String.t()) :: NaiveDateTime.t()
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  @spec before_noon?(NaiveDateTime.t()) :: boolean()
  def before_noon?(datetime), 
    do: datetime |> NaiveDateTime.to_time |> Time.before?(@time_noon)

  @spec return_due_days(NaiveDateTime.t()) :: pos_integer()
  defp return_due_days(checkout_datetime) do
    if before_noon?(checkout_datetime), 
      do: @before_noon_due_days, 
      else: @after_noon_due_days
  end

  @spec return_date(NaiveDateTime.t()) :: DateTime.t()
  def return_date(checkout_datetime) do
    return_days = return_due_days(checkout_datetime)
    checkout_datetime
    |> NaiveDateTime.add(return_days, :day)
    |> NaiveDateTime.to_date
  end

  @spec days_late(Date.t(), NaiveDateTime.t()) :: non_neg_integer()
  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  @spec monday?(NaiveDateTime.t()) :: boolean()
  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date
    |> Date.day_of_week === @monday
  end

  @spec late_fee(pos_integer(), pos_integer()) :: pos_integer()
  defp late_fee(days_late, rate), do: days_late * rate

  @spec apply_discount(pos_integer(), NaiveDateTime.t()) :: pos_integer()
  defp apply_discount(late_fee, return_datetime) do
    if monday?(return_datetime), 
      do: trunc(late_fee / 2), 
      else: late_fee
  end

  @spec calculate_late_fee(String.t(), String.t(), pos_integer()) :: pos_integer()
  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    return_datetime = datetime_from_string(return)

    return_date(checkout_datetime)
    |> days_late(return_datetime)
    |> late_fee(rate)
    |> apply_discount(return_datetime)
  end
end
