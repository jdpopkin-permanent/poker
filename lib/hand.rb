require "cards.rb"

module Poker
  def evaluate
    self.cards.sort_by! { |card| card.value }
    # straight flush
    if flush? && straight?
      return [8] + priority_ordered
    end

    if n_of_a_kind?(4)
      return [7] + priority_ordered
    end

    if n_of_a_kind?(3) && n_of_a_kind?(2)
      return [6] + priority_ordered
    end

    if flush?
      return [5] + priority_ordered
    end

    if straight?
      return [4] + priority_ordered
    end

    if n_of_a_kind?(3)
      return [3] + priority_ordered
    end

    if two_pair?
      return [2] + priority_ordered
    end

    if n_of_a_kind?(2)
      return [1] + priority_ordered
    end

    return [0] + priority_ordered
  end

  def priority_ordered
    grouped_by_value.reverse.sort_by do |group|
      -1 * group[0].value * 20 ** group.count
    end.flatten.map(&:value)
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

  def n_of_a_kind?(n)
    grouped_by_value.any? do |group|
      group.count == n
    end
  end

  def two_pair?
    value_groups = grouped_by_value
    num_pairs = 0

    value_groups.each do |group|
      num_pairs += 1 if group.count == 2
    end

    num_pairs == 2
  end

  def highest_val(card_array)
    card_array.last.value # note: assumes sorted. probably safe.
  end



  private

  def grouped_by_value
    grouped = [[@cards[0]]]
    @cards[1..-1].each_with_index do |card, i|
      if grouped[-1][0].value == card.value
        grouped[-1] << card
      else
        grouped << [card]
      end
    end
    grouped
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

