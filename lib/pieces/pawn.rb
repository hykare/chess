class Pawn < Piece
  def self.for(color)
    if color == :white
      WhitePawn
    else
      BlackPawn
    end.new(color)
  end

  def avatar
    '♟ '
  end

  def move_valid?(move, board)
    valid_capture?(move, board) || valid_non_capture?(move, board) || valid_en_passant?(move, board)
  end

  private

  def valid_capture?(move, board)
    forward?(move) &&
      move.diagonal? &&
      move.distance == 1 &&
      !board.piece_at(move.to).nil?
  end

  def valid_en_passant?(move, board)
    enemy_pawn_position = Position.new(move.from.rank, move.to.file)
    board.piece_at(enemy_pawn_position).is_a?(Pawn) &&
      board.last_move&.to == enemy_pawn_position &&
      board.last_move&.distance == 2 &&
      forward?(move) &&
      move.diagonal? &&
      move.distance == 1 &&
      board.piece_at(move.to).nil?
  end

  def valid_non_capture?(move, board)
    forward?(move) &&
      move.vertical? &&
      (move.distance == 1 || (move.distance == 2 && move.from.rank == starting_rank)) &&
      board.piece_at(move.to).nil?
  end

  def forward?(_move)
    false
  end

  def starting_rank
    nil
  end
end
