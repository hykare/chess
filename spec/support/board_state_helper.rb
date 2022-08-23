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
  end
end

RSpec.configure do |config|
  config.include Helpers::BoardState
end
