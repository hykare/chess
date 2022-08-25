class ExecuteMove
  attr_reader :board, :move

  def initialize(board, move)
    @board = board
    @move = move
  end

  def self.for(board, move)
    if en_passant?(board, move)
      ExecuteEnPassant
    else
      ExecuteMove
    end.new(board, move).execute
  end

  private_class_method def self.en_passant?(board, move)
    board.piece_at(move.from).is_a?(Pawn) &&
    move.diagonal? &&
    board.piece_at(move.to).nil?
  end

  def execute
    board.update(move)
    board.last_move = move
    board.piece_at(move.from).has_moved = true
  end
end

class ExecuteEnPassant < ExecuteMove
  def execute
    board.update(move)
    board.last_move = move

    enemy_pawn_position = Position.new(move.from.rank, move.to.file)
    board.state[enemy_pawn_position] = nil
  end
end
