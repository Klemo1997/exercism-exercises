defmodule TakeANumber do
  @spec start() :: pid()
  def start(), do: spawn(fn -> proc(0) end)

  @spec proc(integer()) :: nil
  defp proc(state) do
    receive do
      {:report_state, pid} -> 
          send(pid, state)
          proc(state)
      {:take_a_number, pid} -> 
          send(pid, state + 1)
          proc(state + 1)
      :stop -> nil
      _ -> proc(state)
    end
  end
end
