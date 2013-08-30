class Player

  attr_reader :purse

  def initialize(id, game, purse, deck)
    @id, @game, @purse = id, game, purse
    @hand = Hand.new(deck)
  end

  def accept_winnings(winnings)
    @purse += winnings
  end

  def place_bet(bet)
    raise IOError if bet > @purse
    @purse -= bet
    @game.take_bet(bet)
  end

  def bet_phase(current_bet)
    puts "Player #{id}'s hand: #{hand.to_s}"
    puts "Player #{id}'s purse: #{purse}"
    puts "Current bet: #{current_bet}"
    puts "Choose to see the bet (S), raise the bet (R), or fold (F)."
    # choice = gets
  end




end