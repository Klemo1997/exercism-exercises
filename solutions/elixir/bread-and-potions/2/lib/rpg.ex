defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0

    @type t :: %Character{}

    @spec add_health_points(Character.t, integer):: Character.t
    def add_health_points(character, hp) do
      Map.update!(character, :health, &(&1 + hp))
    end

    @spec add_mana_points(Character.t, integer):: Character.t
    def add_mana_points(character, mana) do
      Map.update!(character, :mana, &(&1 + mana))
    end
  end

  defmodule LoafOfBread do
    @health_points 5
    defstruct []

    @type t :: %LoafOfBread{}

    @spec health_points():: pos_integer
    def health_points() do
      @health_points
    end
  end

  defmodule ManaPotion do
    defstruct strength: 10

    @type t :: %ManaPotion{}
  end

  defmodule Poison do
    defstruct []

    @type t :: %Poison{}
  end

  defmodule EmptyBottle do
    defstruct []

    @type t :: %EmptyBottle{}
  end

  defprotocol Edible do
    @spec eat(t, Character.t):: {EmptyBottle.t | nil, Character.t}
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    @spec eat(LoafOfBread.t, Character.t):: {nil, Character.t}
    def eat(_, character) do
      {nil, Character.add_health_points(character, LoafOfBread.health_points)}
    end
  end

  defimpl Edible, for: ManaPotion do
    @spec eat(ManaPotion.t, Character.t):: {EmptyBottle.t, Character.t}
    def eat(item, character) do
      {%EmptyBottle{}, Character.add_mana_points(character, item.strength)}
    end
  end

  defimpl Edible, for: Poison do
    @spec eat(Poison.t, Character.t):: {EmptyBottle.t, Character.t}
    def eat(_, character) do
      {%EmptyBottle{}, Character.add_health_points(character, -character.health)}
    end
  end
end