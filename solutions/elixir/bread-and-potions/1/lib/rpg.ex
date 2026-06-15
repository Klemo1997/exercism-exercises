defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0

    def add_health_points(character, hp) do
      Map.update!(character, :health, &(&1 + hp))
    end

    def add_mana_points(character, mana) do
      Map.update!(character, :mana, &(&1 + mana))
    end
  end

  defmodule LoafOfBread do
    @health_points 5
    defstruct []

    def health_points do
      @health_points
    end
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  # Add code to define the protocol and its implementations below here...
end

defprotocol RPG.Edible do
  def eat(item, character)
end

defimpl RPG.Edible, for: RPG.LoafOfBread do
  def eat(_, character) do
    {nil, RPG.Character.add_health_points(character, RPG.LoafOfBread.health_points)}
  end
end

defimpl RPG.Edible, for: RPG.ManaPotion do
  def eat(item, character) do
    {%RPG.EmptyBottle{}, RPG.Character.add_mana_points(character, item.strength)}
  end
end

defimpl RPG.Edible, for: RPG.Poison do
  def eat(_, character) do
    {%RPG.EmptyBottle{}, RPG.Character.add_health_points(character, -character.health)}
  end
end