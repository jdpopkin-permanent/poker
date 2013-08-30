require "rspec"
require "deck.rb"

describe Deck do
  describe "#initalize" do
    subject(:deck) { Deck.new }

    it "creates a deck object" do
      expect(deck).to be_an_instance_of(Deck)
    end

    it "has 52 cards" do
      expect(deck.cards.count).to eq(52)
    end

    it "assigns cards to the deck" do
      expect(deck.cards.first).to be_an_instance_of(Card)
    end

    it "has cards of distinct values" do
      expect(deck.cards.map(&:to_s).count).to eq(deck.cards.map(&:to_s).uniq.count)
    end
  end

  describe "#deal" do
    subject(:deck) { Deck.new }

    it "returns a specified number of cards" do
      expect(deck.deal(5).count).to eq(5)
    end

    it "removes those cards from the deck" do
      deck.deal(5)
      expect(deck.cards.count).to eq(47)
    end

    it "returns unique cards" do
      cards = deck.deal(5)
      expect(cards.length).to eq(cards.uniq.length)
    end
  end
end















