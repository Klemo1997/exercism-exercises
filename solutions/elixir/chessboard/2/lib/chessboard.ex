defmodule Chessboard do
  @spec rank_range() :: Range.t()
  def rank_range do
    1..8
  end

  @spec file_range() :: Range.t()
  def file_range do
    ?A..?H
  end

  @spec ranks() :: list(pos_integer())
  def ranks do
    Enum.to_list(rank_range())
  end

  @spec files() :: list(String.t())
  def files do
    Enum.to_list(file_range()) |> Enum.map(&(<<&1>>))
  end
end
