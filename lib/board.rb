require_relative 'position'
require 'colorize'

class Board
  def initialize(state = default_state)
    @state = state
  end

  def draw
    board = "   a b c d e f g h\n"
    @state.each do |position, piece|
      piece = piece.nil? ? '  ' : piece
      board << "#{position.rank} " if position.file == 'a'
      board << piece.colorize(background: position.color)
      board << " #{position.rank}\n" if position.file == 'h'
    end
    board << "   a b c d e f g h\n"
    print board
  end

  private

  def piece_at(position)
    @state[position]
  end

  def default_state
    # empty board
    state = {}
    Position.all do |position|
      state[position] = nil
    end
    state
  end
end
