require_relative 'position'
require_relative 'piece'
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
                 piece.avatar.colorize(color: piece.color, background: position.color)
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

  private

  def default_state
    state = {}
    Position.all do |position|
      state[position] = Piece.for(position)
    end
    state
  end
end
