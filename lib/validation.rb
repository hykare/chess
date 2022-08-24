class Validation
  attr_reader :message, :board, :move, :player

  def initialize(board, move, player)
    @board = board
    @player = player
    @move = move

    @message = "enter move\n"
  end

  def self.message(board, move, player)
    validation = new(board, move, player)

    (validation.valid? && validation.check_safe?) unless move.nil?
    validation.message
  end

  # piece might be pinned
  def self.threat?(board, move, player)
    new(board, move, player).valid?
  end

  # piece is able to execute a move
  def self.passes?(board, move, player)
    validation = new(board, move, player)
    validation.valid? && validation.check_safe?
  end

  def valid?
    start_position_valid? && target_position_valid? && path_clear? && piece_move_valid?
  end

  def check_safe?
    @message = "you can't leave your king in check\n"
    dummy = board.clone
    dummy.update(move)
    !dummy.check?(player)
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
    @message = "there are other pieces in the way\n"
    move.path.all? { |position| board.piece_at(position).nil? }
  end

  def piece_move_valid?
    @message = "this piece can't move this way\n"
    piece = board.piece_at(move.from)
    piece.move_valid?(move, board)
  end
end
