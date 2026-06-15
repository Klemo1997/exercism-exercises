defmodule HighScore do
  @moduledoc """
    Module for managing high scores for arcade games.
  """

  @type score_map() :: %{optional(String.t()) => integer()}

  @initial_score 0

  @spec new() :: %{}
  def new(), do: Map.new()

  @spec add_player(score_map(), String.t(), integer()) :: score_map()
  def add_player(score_map, name, score \\ @initial_score), do: Map.put(score_map, name, score)

  @spec remove_player(score_map(), String.t()) :: score_map()
  def remove_player(score_map, name), do: Map.delete(score_map, name)

  @spec reset_score(score_map(), String.t()) :: score_map()
  def reset_score(score_map, name), do: Map.put(score_map, name, @initial_score)

  @spec update_score(score_map(), String.t(), integer()) :: score_map()
  def update_score(score_map, name, score) do
    Map.update(score_map, name, score, &(&1 + score))
  end

  @spec get_players(score_map()) :: list(String.t())
  def get_players(score_map), do: Map.keys(score_map)
end
