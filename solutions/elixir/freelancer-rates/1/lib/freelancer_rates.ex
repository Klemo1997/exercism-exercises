defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount * (1 - (discount / 100))
  end

  def monthly_rate(hourly_rate, discount) do
    # Compute unrounded value
    float_val = 22 * (
      hourly_rate
      |> daily_rate()
      |> apply_discount(discount)
    )

    float_val
    # Ceil it to the nearest whole number
    |> Float.ceil()
    # And truncate the float part
    |> Kernel.trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    Float.floor(budget / daily_rate(apply_discount(hourly_rate, discount)), 1)
  end
end
