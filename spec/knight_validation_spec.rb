require_relative '../lib/library'
require_relative './support/board_state_helper'

describe KnightValidation do
  describe '#piece_move_valid?' do
    let(:board) { double(Board) }
    let(:player) { double(Player) }
    subject(:validation) { described_class.new(board, move, player) }

    context 'when moving two squares right and one down' do
      let(:from) { instance_double(Position, rank: 5, file: 'a') }
      let(:to) { instance_double(Position, rank: 4, file: 'c') }
      let(:move) { Move.for(from, to) }
      it 'returns true' do
        expect(validation.piece_move_valid?).to be true
      end
    end

    context 'when moving two squares right' do
      let(:from) { instance_double(Position, rank: 5, file: 'd') }
      let(:to) { instance_double(Position, rank: 5, file: 'f') }
      let(:move) { Move.for(from, to) }
      it 'returns true' do
        expect(validation.piece_move_valid?).to be false
      end
    end
  end
end
