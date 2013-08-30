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

  describe "#n_of_a_kind" do
    let(:deck) { double("deck") }
    subject(:hand) { Hand.new(deck) }

    it "returns true if 4 of a kind with arg 4" do
      five_cards = [Card.new(2, :diamond), Card.new(2, :spade),
        Card.new(2, :heart), Card.new(2, :clud), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.n_of_a_kind?(4)).to be_true
    end

    it "returns false if 4 of a kind with arg 3" do
      five_cards = [Card.new(2, :diamond), Card.new(2, :spade),
        Card.new(2, :heart), Card.new(2, :clud), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.n_of_a_kind?(3)).to be_false
    end


    it "returns false if all cards are unique" do
      five_cards = [Card.new(2, :diamond), Card.new(3, :spade),
        Card.new(4, :spade), Card.new(5, :spade), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.n_of_a_kind?(2)).to be_false
    end
  end

  describe "#two_pair?" do
    let(:deck) { double("deck") }
    subject(:hand) { Hand.new(deck) }

    it "returns true if two distinct pairs exist" do
      five_cards = [Card.new(2, :diamond), Card.new(2, :spade),
        Card.new(3, :heart), Card.new(3, :club), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.two_pair?).to be_true
    end

    it "returns false for full house" do
      five_cards = [Card.new(2, :diamond), Card.new(2, :spade),
        Card.new(3, :heart), Card.new(3, :club), Card.new(3, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.two_pair?).to be_false
    end

    it "returns false when no pairs exist" do
      five_cards = [Card.new(4, :diamond), Card.new(2, :spade),
        Card.new(3, :heart), Card.new(5, :club), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.two_pair?).to be_false
    end
  end

  describe "#highest_val" do
    let(:deck) { double("deck") }
    subject(:hand) { Hand.new(deck) }

    it "returns value of highest card" do
      five_cards = [Card.new(2, :diamond), Card.new(2, :spade),
        Card.new(3, :heart), Card.new(3, :club), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.highest_val(hand.cards)).to eq(6)
    end
  end

  describe "#evaluate" do
    let(:deck) { double("deck") }
    subject(:hand) { Hand.new(deck) }

    it "returns array starting with 0 for High Card" do
      five_cards = [Card.new(2, :diamond), Card.new(4, :spade),
        Card.new(6, :heart), Card.new(8, :club), Card.new(10, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.evaluate).to eq([0, 10, 8, 6, 4, 2])
    end

    it "returns array starting with 1 for One Pair" do
      five_cards = [Card.new(2, :diamond), Card.new(4, :spade),
        Card.new(6, :heart), Card.new(10, :club), Card.new(10, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.evaluate).to eq([1, 10, 10, 6, 4, 2])
    end

    it "returns array starting with 2 for Two Pair" do
      five_cards = [Card.new(4, :diamond), Card.new(4, :spade),
        Card.new(6, :heart), Card.new(10, :club), Card.new(10, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.evaluate).to eq([2, 10, 10, 4, 4, 6])
    end

    it "returns array starting with 3 for Three of a Kind" do
      five_cards = [Card.new(4, :diamond), Card.new(4, :spade),
        Card.new(6, :heart), Card.new(4, :club), Card.new(10, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.evaluate).to eq([3, 4, 4, 4, 10, 6])
    end

    it "returns array starting with 4 for a Straight" do
      five_cards = [Card.new(4, :diamond), Card.new(5, :spade),
        Card.new(6, :heart), Card.new(7, :club), Card.new(8, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.evaluate).to eq([4, 8, 7, 6, 5, 4])
    end

    it "returns array starting with 5 for a Flush" do
      five_cards = [Card.new(2, :spade), Card.new(5, :spade),
        Card.new(6, :spade), Card.new(7, :spade), Card.new(8, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.evaluate).to eq([5, 8, 7, 6, 5, 2])
    end

    it "returns array starting with 6 for a Full House" do
      five_cards = [Card.new(2, :diamond), Card.new(2, :spade),
        Card.new(2, :club), Card.new(8, :diamond), Card.new(8, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.evaluate).to eq([6, 2, 2, 2, 8, 8])
    end

    it "returns array starting with 7 for Four of a Kind" do
      five_cards = [Card.new(2, :diamond), Card.new(2, :spade),
        Card.new(2, :club), Card.new(2, :heart), Card.new(8, :spade)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.evaluate).to eq([7, 2, 2, 2, 2, 8])
    end

    it "returns array starting with 8 for Straight Flush" do
      five_cards = [Card.new(13, :diamond), Card.new(12, :diamond),
        Card.new(11, :diamond), Card.new(10, :diamond), Card.new(9, :diamond)]
      deck.stub(:deal).and_return(five_cards.dup)

      expect(hand.evaluate).to eq([8, 13, 12, 11, 10, 9])
    end
  end

end
