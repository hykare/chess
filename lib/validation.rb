class Validation
  private

  attr_writer :feedback_message

  public

  attr_reader :feedback_message, :board, :move, :player

  def initialize(board, move, player)
    @board = board
    @player = player
    @move = move

    @feedback_message = "enter move\n"
  end

  # piece is able to execute the move
  def self.passes?(board, move, player)
    validation = new(board, move, player)
    validation.move_correct? && validation.check_safe?
  end

  # piece is attacking, but might be pinned
  def self.threat?(board, move, player)
    new(board, move, player).move_correct?
  end

  # validation failure feedback
  def self.feedback(board, move, player)
    validation = new(board, move, player)
    (validation.move_correct? && validation.check_safe?) unless move.nil?
    validation.feedback_message
  end

  def move_correct?
    start_position_valid? && target_position_valid? && path_clear? && piece_move_valid?
  end

  def check_safe?
    self.feedback_message = "you can't leave your king in check\n"
    dummy = board.clone
    ExecuteMove.for(dummy, move)
    !dummy.check?(player)
  end

  private

  def start_position_valid?
    self.feedback_message = "pick a #{player.color} piece to move\n"
    position = move.from
    board.piece_at(position)&.player_color == player.color
  end

  def target_position_valid?
    self.feedback_message = "enter a valid target position\n"
    position = move.to
    position.valid? && board.piece_at(position)&.player_color != player.color
  end

  def path_clear?
    self.feedback_message = "there are other pieces in the way\n"
    board.path_clear?(move)
  end

  def piece_move_valid?
    self.feedback_message = "this piece can't move this way\n"
    piece = board.piece_at(move.from)
    piece.move_valid?(move, board)
  end
end
