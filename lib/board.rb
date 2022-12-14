require 'colorize'

class Board
  attr_accessor :state, :last_move

  def initialize(state = default_state)
    @state = state
    @last_move = nil
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
    under_attack?(king_position, player)
  end

  def under_attack?(position, player)
    Position.all do |start_position|
      move = Move.for(start_position, position)
      opponent = Player.opponent(player)
      return true if Validation.threat?(self, move, opponent)
    end
    false
  end

  def path_clear?(move)
    move.path.all? { |position| piece_at(position).nil? }
  end

  private

  def find_king(player)
    @state.each do |position, piece|
      return position if piece.is_a?(King) && piece.player_color == player.color
    end
  end

  def default_state
    state = {}
    Position.all do |position|
      state[position] = Piece.for(position)
    end
    state
  end

  def initialize_copy(original)
    @state = original.state.clone
  end
end
