defmodule RPG.CharacterSheet do
  @welcome_message "Welcome! Let's fill out your character sheet together."
  @name_prompt_message "What is your character's name?\n"
  @class_prompt_message "What is your character's class?\n"
  @level_prompt_message "What is your character's level?\n"

  @spec welcome() :: :ok
  def welcome() do
    @welcome_message |> IO.puts
  end

  @spec ask_name() :: String.t()
  def ask_name() do
    @name_prompt_message |> IO.gets |> String.trim
  end

  @spec ask_class() :: String.t()
  def ask_class() do
    @class_prompt_message |> IO.gets |> String.trim
  end

  @spec ask_level() :: String.t()
  def ask_level() do
    @level_prompt_message |> IO.gets |> String.trim |> String.to_integer
  end

  @spec run() :: String.t()
  def run() do
    welcome()
    character = %{name: ask_name(), class: ask_class(), level: ask_level()}
    IO.write("Your character: ")
    character |> IO.inspect
  end
end
