defmodule LogLevel do
  @moduledoc """
    Provides logic for log level labeling and alert decisions in case of failures
  """

  @spec to_label(integer(), boolean()) :: atom()
  def to_label(level, legacy?) do
    cond do
      level === 0 and not legacy? -> :trace
      level === 1 -> :debug
      level === 2 -> :info
      level === 3 -> :warning
      level === 4 -> :error
      level === 5 and not legacy? -> :fatal
      true -> :unknown
    end
  end

  @spec alert_recipient(integer(), boolean()) :: atom()|false
  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)
    cond do
      label === :error or label === :fatal -> :ops
      label === :unknown and legacy? -> :dev1
      label === :unknown -> :dev2
      true -> false
    end
  end
end
