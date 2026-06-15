defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  import MapSet

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    {member?(collection, card), put(collection, card)}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    {
      member?(collection, your_card) and not member?(collection, their_card), 
      delete(collection, your_card)
        |> put(their_card)
    }
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    Enum.reduce(cards, new(), &put(&2, &1))
    |> to_list()
    |> Enum.sort()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    difference(your_collection, their_collection)
    |> size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []
  def boring_cards([first | _] = collections) do
    Enum.reduce(collections, first, &intersection/2)
    |> to_list()
    |> Enum.sort()
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards(collections) do
    Enum.reduce(collections, new(), &union/2)
    |> size()
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    MapSet.split_with(collection, &String.starts_with?(&1, "Shiny"))
    |> then(fn {shiny_cards, other_cards} -> {Enum.sort(shiny_cards), Enum.sort(other_cards)} end)
  end
end
