require_relative '../../lib/position'

module Helpers
  module BoardState
    def empty_state
      state = {}
      Position.all do |position|
        state[position] = nil
      end
      state
    end

    def piece_alone(piece, position_string)
      state = empty_state
      position = Position.parse(position_string)
      state[position] = piece
      state
    end

    def white_in_check
      state = empty_state
      state[Position.parse('d5')] = King.new(:white)
      state[Position.parse('d1')] = Rook.new(:black)
      state
    end

    def white_rook_pin
      state = empty_state
      state[Position.parse('d5')] = King.new(:white)
      state[Position.parse('d3')] = Rook.new(:white)
      state[Position.parse('d1')] = Rook.new(:black)
      state
    end

    def white_pawn_captures(white_pawn)
      state = empty_state
      state[Position.parse('b2')] = white_pawn
      state[Position.parse('a3')] = BlackPawn.new(:black)
      state[Position.parse('b4')] = BlackPawn.new(:black)
      state[Position.parse('d4')] = BlackPawn.new(:black)
      state[Position.parse('e5')] = BlackPawn.new(:black)
      state[Position.parse('g5')] = BlackPawn.new(:black)
      state[Position.parse('f6')] = BlackPawn.new(:black)
      state
    end

    def castlemania
      state = empty_state
      state[Position.parse('e8')] = King.new(:black)
      state[Position.parse('a8')] = Rook.new(:black)
      state[Position.parse('e1')] = King.new(:white)
      state[Position.parse('a1')] = Rook.new(:white)
      state[Position.parse('h1')] = Rook.new(:white)
      state
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::BoardState
end
