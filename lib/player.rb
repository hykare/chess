class Player
  attr_reader :color, :type

  def initialize(color, type = :human)
    @color = color
    @type = type
  end

  def self.opponent(player)
    opponent_color = player.color == :white ? :black : :white
    new(opponent_color)
  end

  def to_s
    color.to_s
  end
end
