class Validation
  attr_reader :result, :message, :board, :move, :player

  def initialize(board, move, player)
    @board = board
    @player = player
    @move = move

    @result = evaluate
  end

  def evaluate
    start_position_valid? && target_position_valid? && piece_move_valid?
  end

  def start_position_valid?
    @message = 'pick your own piece to move'
    position = move.from
    board.piece_at(position)&.player_color == player.color
  end

  def target_position_valid?
    @message = 'enter a valid target position'
    position = move.to
    position.valid? && board.piece_at(position)&.player_color != player.color
  end

  def piece_move_valid?
    true
  end
end
