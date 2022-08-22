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

    if position.rank == 7
      Pawn.new(color)
    elsif position.rank == 2
      Pawn.new(color)
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

class Pawn < Piece
  def avatar
    '♟ '
  end

  def move_valid?(move)
    move_one = (move.from.file == move.to.file) && (move.to.rank == move.from.rank + 1)
    move_two = (move.from.file == move.to.file) && (move.from.rank == 2) && (move.to.rank == 4)

    move_one || move_two
  end
end

class Rook < Piece
  def avatar
    '♜ '
  end

  def move_valid?(move)
    move.horizontal? || move.vertical?
  end
end

class Knight < Piece
  def avatar
    '♞ '
  end

  def move_valid?(move)
    [move.horizontal?, move.vertical?, move.diagonal?].none? && move.distance == 2
  end
end

class Bishop < Piece
  def avatar
    '♝ '
  end

  def move_valid?(move)
    move.diagonal?
  end
end

class Queen < Piece
  def avatar
    '♛ '
  end

  def move_valid?(move)
    move.horizontal? || move.vertical? || move.diagonal?
  end
end

class King < Piece
  def avatar
    '♚ '
  end

  def move_valid?(move)
    move.distance == 1
  end
end
