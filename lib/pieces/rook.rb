class Rook < Piece
  def avatar
    '♜ '
  end

  def move_valid?(move, _board)
    move.horizontal? || move.vertical?
  end
end
