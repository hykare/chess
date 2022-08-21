require_relative '../lib/library'
require_relative './support/board_state_helper'

describe RookValidation do
  describe '#piece_move_valid?' do
    let(:board) { double(Board) }
    let(:player) { double(Player) }
    subject(:validation) { described_class.new(board, move, player) }

    context 'when moving horizontally' do
      let(:from) { instance_double(Position, rank: 5, file: 'd') }
      let(:to) { instance_double(Position, rank: 5, file: 'g') }
      let(:move) { Move.for(from, to) }
      it 'returns true' do
        expect(validation.piece_move_valid?).to be true
      end
    end

    context 'when moving vertically' do
      let(:from) { instance_double(Position, rank: 5, file: 'd') }
      let(:to) { instance_double(Position, rank: 8, file: 'd') }
      let(:move) { Move.for(from, to) }
      it 'returns true' do
        expect(validation.piece_move_valid?).to be true
      end
    end

    context 'when moving non-orthogonally' do
      let(:from) { instance_double(Position, rank: 5, file: 'd') }
      let(:to) { instance_double(Position, rank: 7, file: 'f') }
      let(:move) { Move.for(from, to) }
      it 'returns false' do
        expect(validation.piece_move_valid?).to be false
      end
    end
  end
end
