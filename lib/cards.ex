defmodule Cards do
  @moduledoc """
  Documentation for Cards.
  Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Return a list of strings that represents a full deck of cards.
  """
  def create_deck do
    string_numbers = %{
      2 => "Two",
      3 => "Three",
      4 => "Four",
      5 => "Five",
      6 => "Six",
      7 => "Seven",
      8 => "Eight",
      9 => "Nine",
      10 => "Ten"
    }
    values = Enum.concat(Enum.to_list(2..10) |> Enum.map(&(string_numbers[&1])), ["Ace", "King", "Queen", "Jack"])
    suites = ["Hearts", "Spades", "Diamonds", "Clubs"]

    ## Look Mah, list comprehensions!
    for v <- values, s <- suites do
      "#{v} of #{s}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Checks to see if the card exists in the deck or hand of cards

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Two of Hearts")
      true
      
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Two of nil")
      false
  """

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck.
  The `size` argument indicates how many cards for a hand.
  
  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Two of Hearts"]
  """

  def deal(deck, size) do
    Enum.split(deck, size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "Sorry, file #{filename} does not exist."
    end
  end

  def create_hand(size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(size)
  end
end
