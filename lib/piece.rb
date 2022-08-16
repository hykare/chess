require_relative 'position'

class Piece
  attr_reader :color

  WHITE = :light_white
  BLACK = :black

  def initialize(color)
    @color = color
  end

  def self.for(position)
    color = position.rank > 2 ? BLACK : WHITE

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
end

class Pawn < Piece
  def avatar
    '♟ '
  end

  def moves
  end
end

class Rook < Piece
  def avatar
    '♜ '
  end

  def moves
  end
end

class Knight < Piece
  def avatar
    '♞ '
  end

  def moves
  end
end

class Bishop < Piece
  def avatar
    '♝ '
  end

  def moves
  end
end

class Queen < Piece
  def avatar
    '♛ '
  end

  def moves
  end
end

class King < Piece
  def avatar
    '♚ '
  end

  def moves
  end
end
