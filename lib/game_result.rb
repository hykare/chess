class GameResult
  attr_reader :board, :player

  def initialize(board, player)
    @board = board
    @player = player
  end

  def game_over?
    loss? || draw?
  end

  def loss?
    player_in_check && no_legal_moves
  end

  def player_in_check
    board.check?(player)
  end

  def no_legal_moves
    Position.all do |start|
      Position.all do |target|
        move = Move.for(start, target)
        return false if Validation.passes?(board, move, player)
      end
    end
    true
  end

  def draw?
    false
  end
end
