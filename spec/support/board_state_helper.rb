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
  end
end

RSpec.configure do |config|
  config.include Helpers::BoardState
end
