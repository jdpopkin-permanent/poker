require "cards.rb"

module Poker
  def evaluate
    self.cards.sort_by! { |card| card.value }
  end

  def flush?
    suit = self.cards.first.suit
    self.cards.all? { |card| card.suit == suit }
  end

  def straight?
    offset = self.cards[0].value
    self.cards.each_with_index do |card, i|
      return false unless offset + i == card.value
    end
    true
  end
end

class Hand

  include Poker

  attr_reader :cards

  def initialize(deck)
    @cards = []
    @deck = deck
    @cards += draw(5)
  end

  def to_s
    @cards.map(&:to_s)
  end

  def discard(indexes)
    new_cards = draw(indexes.count)

    indexes.each do |index|
      self.cards[index] = new_cards.pop
    end
  end

  private

  def draw(number)
    @deck.deal(number)
  end
end

