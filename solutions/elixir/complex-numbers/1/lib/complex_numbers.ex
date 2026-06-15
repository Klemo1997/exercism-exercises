defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real({real, _imaginary}), do: real

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary({_real, imaginary}), do: imaginary

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul(a, b) when is_number(a), do: mul({a, 0}, b)
  def mul(a, b) when is_number(b), do: mul(a, {b, 0})
  def mul({a, b}, {c, d}), do: {a * c - b * d, b * c + a * d}

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add(a, b) when is_number(a), do: add({a, 0}, b)
  def add(a, b) when is_number(b), do: add(a, {b, 0})
  def add({a, b}, {c, d}), do: {a + c, b + d}

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub(a, b) when is_number(a), do: sub({a, 0}, b)
  def sub(a, b) when is_number(b), do: sub(a, {b, 0})
  def sub({a, b}, {c, d}), do: {a - c, b - d}

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div(a, b) when is_number(a), do: __MODULE__.div({a, 0}, b)
  def div(a, b) when is_number(b), do: __MODULE__.div(a, {b, 0})
  def div({a, b}, {c, d}), do: {(a * c + b * d) / (c**2 + d**2), (b * c - a * d) / (c**2 + d**2)}

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs({a, b}), do: :math.sqrt(a*a + b*b)

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({a, b}), do: {a, -b}

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({a, b}), do: {:math.exp(a) * :math.cos(b), :math.exp(a) * :math.sin(b)}
end
