class ExecuteMove
  attr_reader :board, :move

  def initialize(board, move)
    @board = board
    @move = move
  end

  def self.for(board, move)
    if en_passant?(board, move)
      ExecuteEnPassant
    elsif castling?(board, move)
      ExecuteCastling
    else
      ExecuteMove
    end.new(board, move).execute
  end

  private_class_method def self.en_passant?(board, move)
    board.piece_at(move.from).is_a?(Pawn) &&
    move.diagonal? &&
    board.piece_at(move.to).nil?
  end

  private_class_method def self.castling?(board, move)
    board.piece_at(move.from).is_a?(King) &&
    move.distance == 2
  end

  def execute
    board.piece_at(move.from).has_moved = true
    board.update(move)
    board.last_move = move
  end
end

class ExecuteEnPassant < ExecuteMove
  def execute
    super

    enemy_pawn_position = Position.new(move.from.rank, move.to.file)
    board.state[enemy_pawn_position] = nil
  end
end

class ExecuteCastling < ExecuteMove
  def execute
    super

    board.update(rook_move)
  end

  def rook_move
    rank = move.from.rank
    rook_start_file = move.from < move.to ? 'h' : 'a'
    rook_target_file = move.from < move.to ? 'f' : 'd'

    rook_start_position = Position.new(rank, rook_start_file)
    rook_target_position = Position.new(rank, rook_target_file)

    Move.for(rook_start_position, rook_target_position)
  end
end
