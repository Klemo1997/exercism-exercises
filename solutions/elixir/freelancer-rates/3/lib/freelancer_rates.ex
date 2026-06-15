defmodule FreelancerRates do
  @moduledoc """
    Module that helps to communicate rates and discounts regarding his paycheck.
  """

  @workday_hours 8.0
  @month_workdays 22
  @budget_day_max_decimals 1

  @spec daily_rate(number()) :: float()
  def daily_rate(hourly_rate), do: hourly_rate * @workday_hours

  @spec apply_discount(number(), number()) :: float()
  def apply_discount(before_discount, discount) do
    before_discount - (before_discount / 100) * discount
  end

  @spec monthly_rate(number(), number()) :: integer()
  def monthly_rate(hourly_rate, discount) do
    daily_rate(hourly_rate)
      |> apply_discount(discount)
      |> monthly_rate
      |> Float.ceil
      |> Kernel.trunc
  end

  @spec monthly_rate(number()) :: number()
  defp monthly_rate(daily_rate), do: daily_rate * @month_workdays

  @doc "Calculates how many days of work does given budget cover"
  @spec days_in_budget(number(), number(), number()) :: float()
  def days_in_budget(budget, hourly_rate, discount) do
    discounted_daily_rate = 
      hourly_rate
      |> daily_rate
      |> apply_discount(discount)

    budget / discounted_daily_rate
      |> Float.floor(@budget_day_max_decimals)
  end
end
