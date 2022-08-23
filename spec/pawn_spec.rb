require_relative '../lib/library'
require_relative './support/board_state_helper'

describe Pawn do
  describe '#move_valid?' do
    context 'when not capturing' do
      subject(:pawn) { Pawn.new(:white) }

      context 'when moving one square forward' do
        let(:move) { Move.parse('c2 to c3') }
        it 'returns true'
      end
      context 'when moving two squares forward from starting rank' do
        let(:move) { Move.parse('c2 to c4') }
        it 'returns true'
      end
      context 'when moving two squares forward from rank other than starting' do
        let(:move) { Move.parse('c3 to c5') }
        it 'returns false'
      end
      context 'when moving one square diagonally' do
        let(:move) { Move.parse('c3 to d4') }
        it 'returns false'
      end
      context 'when moving two squares diagonally' do
        let(:move) { Move.parse('c3 to e5') }
        it 'returns false'
      end
    end

    context 'when capturing' do
      context 'when moving vertically one square forward'
      context 'when moving vertically two squares forward'
      context 'when moving diagonally one square forward'
      context 'when moving diagonally two squares forward'
    end
  end
end
