defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0

    @type t :: %__MODULE__{
      health: non_neg_integer(),
      mana: non_neg_integer(),
    }
  end

  defmodule LoafOfBread do
    defstruct []
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

  defprotocol Edible do
    @spec eat(map(), Character.t()) :: {map()|nil, Character.t()}
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(%LoafOfBread{}, %Character{health: health} = character) do
      {nil, %{character | health: health + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(%ManaPotion{strength: potion_mana}, %Character{mana: mana} = character) do
      {%EmptyBottle{}, %{character | mana: mana + potion_mana}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(%Poison{}, %Character{} = character) do
      {%EmptyBottle{}, %{character | health: 0}}
    end
  end
end
