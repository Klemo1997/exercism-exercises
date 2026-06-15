defmodule RPNCalculatorInspection do
  @timeout 100

  def start_reliability_check(calculator, input) do
    %{input: input, pid: spawn_link(fn -> calculator.(input) end)}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put(results, input, :error)
    after
      @timeout -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    trap_before? = Process.flag(:trap_exit, true)

    check_results =
      inputs
      |> Enum.map(&start_reliability_check(calculator, &1))
      |> Enum.reduce(%{}, &await_reliability_check_result/2)

    Process.flag(:trap_exit, trap_before?)

    check_results
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(&Task.async(fn -> calculator.(&1) end))
    |> Enum.map(&Task.await(&1, @timeout))
  end
end
