class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def self.opponent(player)
    opponent_color = player.color == :white ? :black : :white
    new(opponent_color)
  end
end
