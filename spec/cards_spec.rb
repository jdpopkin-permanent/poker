require "rspec"
require "cards.rb"

describe Card do
  describe "#initalize" do
    subject(:ace_spades) { Card.new(14,:spade) }
    it "creates a card object" do
      expect(ace_spades).to be_an_instance_of(Card)
    end
  end

  describe "#to_s" do
    subject(:card) do
       Card.new(value, suit)
    end
    context "Ace of Spades" do
      let(:value) { 14 }
      let(:suit) { :spade }

      it "states AS" do
        expect(card.to_s).to eq("AS")
      end
    end

    context "4 of Heart" do
      let(:value) { 4 }
      let(:suit) { :heart }

      it "states 4H" do
        expect(card.to_s).to eq("4H")
      end
    end

    context "Queen of Clubs" do
      let(:value) { 12 }
      let(:suit) { :club }

      it "states QC" do
        expect(card.to_s).to eq("QC")
      end
    end
  end
end