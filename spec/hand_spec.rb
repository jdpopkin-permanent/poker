require "rspec"
require "hand.rb"

describe Hand do
  describe "#initalize" do
    let(:deck) { double("deck") }
    subject(:hand) { Hand.new(deck) }

    it "should contain 5 card" do
      five_cards = [Card.new(2, :spade), Card.new(3, :spade),
        Card.new(4, :spade), Card.new(5, :spade), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards)
      # hand = Hand.new(deck)
      expect(hand.cards.count).to eq(5)
    end
  end

  describe "to_s" do
    let(:deck) { double("deck") }
    subject(:hand) { Hand.new(deck) }

    it "replace 0 cards when passed []" do
      five_cards = [Card.new(2, :spade), Card.new(3, :spade),
        Card.new(4, :spade), Card.new(5, :spade), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards)

      expect(hand.to_s).to eq(["2S","3S","4S","5S","6S"])
    end
  end

  describe "#discard" do
    let(:deck) { double("deck") }
    subject(:hand) { Hand.new(deck) }

    it "replace 0 cards when passed []" do
      five_cards = [Card.new(2, :spade), Card.new(3, :spade),
        Card.new(4, :spade), Card.new(5, :spade), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards)

      hand.discard([])

      expect(hand.to_s).to eq(["2S","3S","4S","5S","6S"])
    end

    it "replace 2S cards when passed [0]" do
      five_cards = [Card.new(2, :spade), Card.new(3, :spade),
        Card.new(4, :spade), Card.new(5, :spade), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      hand.discard([0])

      expect(hand.to_s).to eq(["6S","3S","4S","5S","6S"])
    end

    it "replaces 3 cards when passed [1, 2, 4]" do
      five_cards = [Card.new(2, :spade), Card.new(3, :spade),
        Card.new(4, :spade), Card.new(5, :spade), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)
      # hand created here?
      # modify deck behavior here
      hand.discard([1, 2, 4])

      expect(hand.to_s).to eq(["2S","6S","5S","5S","4S"])
    end
  end

  describe "#flush?" do
    let(:deck) { double("deck") }
    subject(:hand) { Hand.new(deck) }

    it "returns true if all cards have same suit" do
      five_cards = [Card.new(2, :spade), Card.new(3, :spade),
        Card.new(4, :spade), Card.new(5, :spade), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.flush?).to be_true
    end

    it "returns false otherwise" do
      five_cards = [Card.new(2, :diamond), Card.new(3, :spade),
        Card.new(4, :spade), Card.new(5, :spade), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.flush?).to be_false
    end
  end

  describe "#straight" do
    let(:deck) { double("deck") }
    subject(:hand) { Hand.new(deck) }

    it "returns true if all cards are in order" do
      five_cards = [Card.new(2, :diamond), Card.new(3, :spade),
        Card.new(4, :spade), Card.new(5, :spade), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.straight?).to be_true
    end

    it "returns false if its not a straight" do
      five_cards = [Card.new(11, :diamond), Card.new(3, :spade),
        Card.new(4, :spade), Card.new(5, :spade), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.straight?).to be_false
    end
  end
end
