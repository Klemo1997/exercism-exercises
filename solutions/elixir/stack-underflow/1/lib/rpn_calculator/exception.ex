defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @message "stack underflow occurred"
    defexception message: @message

    @impl true
    def exception([]), do: %__MODULE__{}
    def exception(value), do: %__MODULE__{message: @message <> ", context: #{value}"}
  end

  def divide([]), do: raise StackUnderflowError, "when dividing"
  def divide([_]), do: raise StackUnderflowError, "when dividing"
  def divide([0, _]), do: raise DivisionByZeroError
  def divide([divisor, dividend]), do: dividend/divisor
end
