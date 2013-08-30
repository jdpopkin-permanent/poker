class Card

  attr_reader :value, :suit

  def initialize(value, suit)
    @value, @suit = value, suit
  end

  def to_s
    suit = @suit.to_s[0].upcase
    hash = {11 => "J", 12 => "Q", 13 => "K", 14 => "A"}
    if hash.has_key?(@value)
      val = hash[@value]
    else
      val = @value.to_s
    end
    val + suit
  end
end