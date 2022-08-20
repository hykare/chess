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

    def piece_alone(piece)
      state = {}
      state[Position.parse('d5')] = piece
      state
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::BoardState
end
