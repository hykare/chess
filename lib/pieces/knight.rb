class Knight < Piece
  def avatar
    '♞ '
  end

  def move_valid?(move, _board)
    [move.horizontal?, move.vertical?, move.diagonal?].none? && move.distance == 2
  end
end
