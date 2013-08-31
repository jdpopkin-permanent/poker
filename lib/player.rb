class Player

  attr_reader :purse, :id
  attr_accessor :hand

  def initialize(id, game, purse, deck)
    @id, @game, @purse = id, game, purse
    # @hand = Hand.new(deck)
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
    puts "Player #{@id}'s hand: #{hand.to_s}"
    puts "Player #{@id}'s purse: #{purse}"
    puts "Current bet: #{current_bet}"
    puts "Choose to see the bet (S), raise the bet (R), or fold (F)."
    choice = gets.chomp.upcase[0]
    raise IOError.new unless ["S", "R", "F"].include?(choice)
    case choice #TODO
    when "S"
      place_bet(current_bet)
      current_bet
    when "R"
      begin
        puts "How much do you want to raise by?"
        amount = gets.chomp.to_i
        raise IOError unless amount > 0
        place_bet(current_bet + amount)
        current_bet + amount
      rescue IOError => e
        retry
      end
    when "F"
      @game.fold(self) # remove this player from contention this round
      current_bet
    end

  rescue IOError
    retry
  end

  def discard_phase
    puts "Player #{@id}'s turn to discard."
    puts "Choose cards to discard (by index, starting at zero). Separate with commas."
    puts self.hand.inspect
    choices = gets.chomp.split(",").map(&:to_i)
    self.hand.discard(choices)
  end




end