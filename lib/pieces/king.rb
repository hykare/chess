class King < Piece
  def avatar
    '♚ '
  end

  def move_valid?(move, board)
    move.distance == 1 || valid_castling?(move, board)
  end

  def valid_castling?(move, board)
    rook_file = move.to > move.from ? 'h' : 'a'
    rook_position = Position.new(move.from.rank, rook_file)
    king_position = move.from
    player = Player.new(player_color)

    move.horizontal? &&
      move.distance == 2 &&
      has_moved == false &&
      board.piece_at(rook_position)&.has_moved == false &&
      board.path_clear?(Move.for(king_position, rook_position)) &&
      board.check?(player) == false && # has to be after disqualifying attack by enemy king
      board.under_attack?(move.path.first, player) == false
  end
end
