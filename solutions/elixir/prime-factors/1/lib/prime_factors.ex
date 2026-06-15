defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number), do: collect_factors(number, [], 2)

  defp collect_factors(1, factors, _), do: Enum.reverse(factors)
  defp collect_factors(n, factors, factor) when rem(n, factor) == 0, do: collect_factors(trunc(n/factor), [factor | factors], factor)
  defp collect_factors(n, factors, factor), do: collect_factors(n, factors, factor+1)
end
