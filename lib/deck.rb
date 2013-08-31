require_relative "cards.rb"

class Deck

  attr_reader :cards

  def initialize
    @cards = make_deck
    @cards.shuffle!
  end

  def make_deck
    # populate with all possible cards
    suits = [:spade, :heart, :club, :diamond]

    [].tap do |arr|
      suits.each do |suit|
        (2..14).each do |value|
          arr << Card.new(value, suit)
        end
      end
    end
  end

  def deal(number_of_cards)
    self.cards.pop(number_of_cards)
  end




end