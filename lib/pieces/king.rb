class King < Piece
  def avatar
    '♚ '
  end

  def move_valid?(move, _board)
    move.distance == 1
  end
end
