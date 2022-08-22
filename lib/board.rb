require 'colorize'

class Board
  def initialize(state = default_state)
    @state = state
  end

  def draw
    board = "   a b c d e f g h\n"
    @state.each do |position, piece|
      board << "#{position.rank} " if position.starts_rank?
      board << if piece.nil?
                 '  '.colorize(background: position.color)
               else
                 piece.avatar.colorize(color: piece.render_color, background: position.color)
               end
      board << " #{position.rank}\n" if position.ends_rank?
    end
    board << "   a b c d e f g h\n"
    print board
  end

  def piece_at(position)
    @state[position]
  end

  def update(move)
    @state[move.to] = @state[move.from]
    @state[move.from] = nil
  end

  def check?(player)
    king_position = find_king(player)
    Position.all do |start_position|
      move = Move.for(start_position, king_position)
      opponent = Player.opponent(player)
      return true if Validation.for(self, move, opponent).result
    end
    false
  end

  def find_king(player)
    @state.each do |position, piece|
      return position if piece.is_a?(King) && piece.player_color == player.color
    end
  end

  private

  def default_state
    state = {}
    Position.all do |position|
      state[position] = Piece.for(position)
    end
    state
  end
end
