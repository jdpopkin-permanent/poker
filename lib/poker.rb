require_relative "cards.rb"
require_relative "deck.rb"
require_relative "hand.rb"
require_relative "player.rb"

class Poker

  def initialize(num_players = 4)
    
    @players = []
    base_purse = 100 # can change
    @ante = 1 # can change
    @deck = Deck.new
    num_players.times do |i|
      @players << Player.new(i + 1, self, base_purse, @deck)
    end
  end

  def play
    loop do
      play_hand
    end
  end

  def fold(player)
    @folded_players << player
  end

  def take_bet(bet)
    @pot += bet
  end

  def play_hand
    @pot = 0
    players_this_hand = @players.dup
    @folded_players = []

    # deal cards
    @players.each do |player|
      hand = Hand.new(@deck)
      player.hand = hand
    end

    # ante up
    @players.each do |player|
      player.place_bet(@ante)
    end

    # players bet
    current_bet = bet_phase(@ante, players_this_hand)

    #p @folded_players
    players_this_hand -= @folded_players
    #p players_this_hand

    # players discard and redraw
    players_this_hand.each do |player|
      player.discard_phase
    end

    # players bet again
    current_bet = bet_phase(current_bet, players_this_hand)
    players_this_hand -= @folded_players

    # compare hands
    players_this_hand.sort_by do |player| 
      vals = player.hand.evaluate
      vals[0] * 1_000_000 + vals[1] * 10_000 + vals[2] * 100 + vals[3]
    end

    puts "Player #{players_this_hand.last.id} wins!"
    puts players_this_hand.last.hand
    players_this_hand.last.accept_winnings(@pot)
    @pot = 0
  end

  def bet_phase(current_bet, players)
    players.each do |player| 
      current_bet = player.bet_phase(current_bet)
    end
    current_bet
  end

end

if __FILE__ == $PROGRAM_NAME
  p = Poker.new(4)
  p.play
end