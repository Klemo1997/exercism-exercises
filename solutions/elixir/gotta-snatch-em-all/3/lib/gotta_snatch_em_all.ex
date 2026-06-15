defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card), do: MapSet.new([card])

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection),
    do: {MapSet.member?(collection, card), MapSet.put(collection, card)}

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection),
    do: {
          MapSet.member?(collection, your_card) and not MapSet.member?(collection, their_card), 
          MapSet.delete(collection, your_card) |> MapSet.put(their_card)
        }

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards),
    do: Enum.reduce(cards, MapSet.new(), &MapSet.put(&2, &1))
      |> MapSet.to_list()
      |> Enum.sort()

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection),
    do: MapSet.difference(your_collection, their_collection)
      |> MapSet.size()

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []
  def boring_cards([first | collections]),
    do: Enum.reduce(collections, first, &MapSet.intersection/2)
      |> MapSet.to_list()
      |> Enum.sort()

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards(collections) do
    Enum.reduce(collections, MapSet.new(), &MapSet.union/2)
    |> MapSet.size()
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    MapSet.split_with(collection, &String.starts_with?(&1, "Shiny"))
    |> then(fn {shiny_cards, other_cards} -> {Enum.sort(shiny_cards), Enum.sort(other_cards)} end)
  end
end
