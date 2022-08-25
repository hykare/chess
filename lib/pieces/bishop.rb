class Bishop < Piece
  def avatar
    '♝ '
  end

  def move_valid?(move, _board)
    move.diagonal?
  end
end
