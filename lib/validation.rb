class Validation
  attr_reader :result, :message, :board, :move, :player

  def initialize(board, move, player)
    @board = board
    @player = player
    @move = move

    @result = nil
    @message = "enter move\n"
  end

  def self.for(board, move, player)
    return new(board, move, player) if move.nil?

    piece = board.piece_at(move.from)

    case piece
    when Pawn
      PawnValidation
    when Rook
      RookValidation
    when Knight
      KnightValidation
    when Bishop
      BishopValidation
    when Queen
      QueenValidation
    when King
      KingValidation
    else
      self
    end.new(board, move, player).evaluate
  end

  def self.valid?(board, move, player)
    self.for(board, move, player).result
  end

  def self.message(board, move, player)
    self.for(board, move, player).message
  end

  def evaluate
    @result = start_position_valid? && target_position_valid? && path_clear? && piece_move_valid?
    self
  end

  def start_position_valid?
    @message = "pick a #{player.color} piece to move\n"
    position = move.from
    board.piece_at(position)&.player_color == player.color
  end

  def target_position_valid?
    @message = "enter a valid target position\n"
    position = move.to
    position.valid? && board.piece_at(position)&.player_color != player.color
  end

  def path_clear?
    move.path.all? { |position| board.piece_at(position).nil? }
  end

  def piece_move_valid?
    true
  end
end
