require_relative '../lib/library'
require_relative './support/board_state_helper'

describe RookValidation do
  describe '#piece_move_valid?' do
    let(:piece) { Rook.new(:white) }
    let(:board) { Board.new(piece_alone(piece)) }
    let(:player) { Player.new(:white) }
    subject(:validation) { RookValidation.new(board, move, player) }

    context 'when moving horizontally' do
      let(:move) { Move.parse('d5 to g5') }
      it 'returns true' do
        expect(validation.piece_move_valid?).to be true
      end
    end

    context 'when moving vertically' do
      let(:move) { Move.parse('d5 to d8') }
      it 'returns true' do
        expect(validation.piece_move_valid?).to be true
      end
    end

    context 'when moving non-orthogonally' do
      let(:move) { Move.parse('d5 to f7') }
      it 'returns false' do
        expect(validation.piece_move_valid?).to be false
      end
    end
  end
end
