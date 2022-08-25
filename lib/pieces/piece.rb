class Piece
  attr_reader :player_color, :render_color

  LIGHT = :light_white
  DARK = :black

  def initialize(color)
    @player_color = color
    @render_color = @player_color == :white ? LIGHT : DARK
  end

  def self.for(position)
    color = position.rank > 2 ? :black : :white

    if [2, 7].include?(position.rank)
      Pawn.for(color)
    elsif [8, 1].include?(position.rank) && 'ah'.include?(position.file)
      Rook.new(color)
    elsif [8, 1].include?(position.rank) && 'bg'.include?(position.file)
      Knight.new(color)
    elsif [8, 1].include?(position.rank) && 'cf'.include?(position.file)
      Bishop.new(color)
    elsif [8, 1].include?(position.rank) && 'd'.include?(position.file)
      Queen.new(color)
    elsif [8, 1].include?(position.rank) && 'e'.include?(position.file)
      King.new(color)
    end
  end

  def move_valid?(_move)
    false
  end
end
