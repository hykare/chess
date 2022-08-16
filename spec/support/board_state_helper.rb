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
  end
end

RSpec.configure do |config|
  config.include Helpers::BoardState
end
