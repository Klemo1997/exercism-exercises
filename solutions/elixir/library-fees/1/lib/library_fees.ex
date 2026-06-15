defmodule LibraryFees do
  @spec datetime_from_string(String.t):: NaiveDateTime.t
  def datetime_from_string(string) do
    {:ok, date} = NaiveDateTime.from_iso8601(string)
    date
  end

  @noon_hour 12

  @spec before_noon?(NaiveDateTime.t):: boolean
  def before_noon?(datetime) do
    datetime.hour < @noon_hour
  end

  @before_noon_term_days 28
  @after_noon_term_days 29

  @spec return_date(NaiveDateTime.t):: Date.t
  def return_date(checkout_datetime) do
    add = if before_noon?(checkout_datetime),
             do: @before_noon_term_days,
             else: @after_noon_term_days
    Date.add(checkout_datetime, add)
  end

  @spec days_late(NaiveDateTime.t, NaiveDateTime.t):: non_neg_integer
  def days_late(planned_return_date, actual_return_datetime) do
    return_diff = Date.diff(planned_return_date, actual_return_datetime)

    if return_diff > 0,
       do: 0,
       else: Kernel.abs(return_diff)
  end

  @monday 1

  @spec monday?(NaiveDateTime.t):: boolean
  def monday?(datetime) do
    Date.day_of_week(datetime) == @monday
  end

  @spec calculate_late_fee(String.t, String.t, non_neg_integer):: non_neg_integer
  def calculate_late_fee(checkout, return, rate) do
    return_datetime = datetime_from_string(return)

    checkout
    |> datetime_from_string()
    |> return_date()
    |> days_late(return_datetime)
    |> Kernel.*(rate)
    |> get_definitive_fee(return_datetime)
  end

  @special_offer_multiplier 0.5

  @spec get_definitive_fee(non_neg_integer, NaiveDateTime.t):: non_neg_integer
  defp get_definitive_fee(fee, return_datetime) do
    if monday?(return_datetime),
       do: Kernel.floor(fee * @special_offer_multiplier),
       else: fee
  end
end
