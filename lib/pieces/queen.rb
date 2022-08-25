class Queen < Piece
  def avatar
    '♛ '
  end

  def move_valid?(move, _board)
    move.horizontal? || move.vertical? || move.diagonal?
  end
end
