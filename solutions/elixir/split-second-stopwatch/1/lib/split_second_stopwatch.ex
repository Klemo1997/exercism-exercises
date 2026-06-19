defmodule SplitSecondStopwatch do
  @doc """
  A stopwatch that can be used to track lap times.
  """

  @type state :: :ready | :running | :stopped

  defmodule Stopwatch do
    @type t :: :todo
    defstruct [:state, :laps]
  end

  @spec new() :: Stopwatch.t()
  def new(), do: %Stopwatch{state: :ready, laps: [~T[00:00:00]]}

  @spec state(Stopwatch.t()) :: state()
  def state(%Stopwatch{state: state}), do: state

  @spec current_lap(Stopwatch.t()) :: Time.t()
  def current_lap(%Stopwatch{laps: [current_lap | _]}), do: current_lap

  @spec previous_laps(Stopwatch.t()) :: [Time.t()]
  def previous_laps(%Stopwatch{laps: [_ | previous_laps]}), do: Enum.reverse(previous_laps)

  @spec advance_time(Stopwatch.t(), Time.t()) :: Stopwatch.t()
  def advance_time(%Stopwatch{state: :running, laps: [current_lap | previous_laps]} = stopwatch, time),
    do: %{stopwatch | laps: [add(current_lap, time) | previous_laps]}
  def advance_time(%Stopwatch{state: :stopped} = stopwatch, _), do: stopwatch

  @spec total(Stopwatch.t()) :: Time.t()
  def total(%Stopwatch{laps: laps}),
    do: Enum.reduce(laps, ~T[00:00:00], &add/2)

  @spec start(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def start(%Stopwatch{state: :ready} = stopwatch), do: %{stopwatch | state: :running}
  def start(%Stopwatch{state: :stopped} = stopwatch), do: %{stopwatch | state: :running}
  def start(%Stopwatch{state: :running}), do: {:error, "cannot start an already running stopwatch"}

  @spec stop(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def stop(%Stopwatch{state: :running} = stopwatch), do: %{stopwatch | state: :stopped}
  def stop(%Stopwatch{state: _}), do: {:error, "cannot stop a stopwatch that is not running"}

  @spec lap(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()} 
  def lap(%Stopwatch{state: :running, laps: laps} = stopwatch), do: %{stopwatch | laps: [~T[00:00:00] | laps]}
  def lap(%Stopwatch{state: _}), do: {:error, "cannot lap a stopwatch that is not running"}

  @spec reset(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()} 
  def reset(%Stopwatch{state: :stopped} = stopwatch), do: new()
  def reset(%Stopwatch{state: _}), do: {:error, "cannot reset a stopwatch that is not stopped"}

  defp add(%Time{} = time, %Time{} = another_time), do: Time.add(time, 3600 * another_time.hour + 60 * another_time.minute + another_time.second)
end
