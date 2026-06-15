defmodule Secrets do
  @docmodule """
    Provides functionality for an encryption device
  """
  @type transformer() :: (number() -> number())

  @spec secret_add(number()) :: transformer()
  def secret_add(secret) do
    &(&1 + secret)
  end

  @spec secret_subtract(number()) :: transformer()
  def secret_subtract(secret) do
    &(&1 - secret)
  end

  @spec secret_multiply(number()) :: transformer()
  def secret_multiply(secret) do
    &(&1 * secret)
  end

  @spec secret_divide(number()) :: transformer()
  def secret_divide(secret) do
    &(div(&1, secret))
  end

  @spec secret_and(number()) :: transformer()
  def secret_and(secret) do
    &(Bitwise.band(&1, secret))
  end

  @spec secret_xor(number()) :: transformer()
  def secret_xor(secret) do
    &(Bitwise.bxor(&1, secret))
  end

  @spec secret_combine(transformer(), transformer()) :: transformer()
  def secret_combine(secret_function1, secret_function2) do
    &(secret_function2.(secret_function1.(&1)))
  end
end
