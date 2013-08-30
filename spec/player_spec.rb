require "rspec"
require "player.rb"

describe Player do
  let(:game) { double("game" ) }
  let(:deck) { double("deck") }
  let(:hand) { double("hand") }

  subject(:player) { Player.new(1, game, 100, deck) }

  describe "accept_winnings" do
    it "should add winning to the players purse" do
      five_cards = [Card.new(2, :spade), Card.new(3, :spade),
        Card.new(4, :spade), Card.new(5, :spade), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards)

      player.accept_winnings(10)

      expect(player.purse).to eq(110)
    end
  end

  describe "place_bet" do
    it "should deduct the bet from the players purse and place it in game.pot" do
      five_cards = [Card.new(2, :spade), Card.new(3, :spade),
        Card.new(4, :spade), Card.new(5, :spade), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards)
      game.stub(:take_bet)

      player.place_bet(10)

      expect(player.purse).to eq(90)
    end

    it "should raise an error if the bet excedes the player purse" do
      five_cards = [Card.new(2, :spade), Card.new(3, :spade),
        Card.new(4, :spade), Card.new(5, :spade), Card.new(6, :spade)]
      deck.stub(:deal).and_return(five_cards)
      game.stub(:take_bet)


      expect{ player.place_bet(110) }.to raise_error
    end
  end


end