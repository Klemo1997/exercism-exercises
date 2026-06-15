defmodule FreelancerRates do
  @daily_billable_hours 8.0
  @monthly_billable_days 22

  def daily_rate(hourly_rate), 
    do: hourly_rate * @daily_billable_hours

  def apply_discount(before_discount, discount),
    do: before_discount * (100 - discount) / 100

  defp daily_discounted_rate(hourly_rate, discount),
    do: daily_rate(hourly_rate)
      |> apply_discount(discount)

  def monthly_rate(hourly_rate, discount),
    do: daily_discounted_rate(hourly_rate, discount) * @monthly_billable_days
      |> ceil()

  def days_in_budget(budget, hourly_rate, discount),
    do: budget / daily_discounted_rate(hourly_rate, discount)
      |> Float.floor(1)
end
