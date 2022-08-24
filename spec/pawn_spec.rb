require_relative '../lib/library'
require_relative './support/board_state_helper'

describe Pawn do
  describe '#move_valid?' do
    context 'when not capturing' do
      subject(:pawn) { WhitePawn.new(:white) }
      let(:board) { Board.new }
      context 'when moving one square forward' do
        let(:move) { Move.parse('c2 to c3') }
        it 'returns true' do
          expect(pawn.move_valid?(move, board)).to be true
        end
      end
      context 'when moving two squares forward from starting rank' do
        let(:move) { Move.parse('c2 to c4') }
        it 'returns true' do
          expect(pawn.move_valid?(move, board)).to be true
        end
      end
      context 'when moving two squares forward from rank other than starting' do
        let(:move) { Move.parse('c3 to c5') }
        it 'returns false' do
          expect(pawn.move_valid?(move, board)).to be false
        end
      end
      context 'when moving one square diagonally' do
        let(:move) { Move.parse('c3 to d4') }
        it 'returns false' do
          expect(pawn.move_valid?(move, board)).to be false
        end
      end
      context 'when moving two squares diagonally' do
        let(:move) { Move.parse('c3 to e5') }
        it 'returns false' do
          expect(pawn.move_valid?(move, board)).to be false
        end
      end
      context 'when moving backwards' do
        let(:move) { Move.parse('c3 to d2') }
        it 'returns false' do
          expect(pawn.move_valid?(move, board)).to be false
        end
      end
    end

    context 'when capturing' do
      subject(:pawn) { WhitePawn.new(:white) }
      let(:board) { Board.new(white_pawn_captures(pawn)) }

      context 'when moving vertically one square forward' do
        let(:move) { Move.parse('f5 to f6') }
        it 'returns false' do
          expect(pawn.move_valid?(move, board)).to be false
        end
      end
      context 'when moving vertically two squares forward' do
        let(:move) { Move.parse('b2 to b4') }
        it 'returns false' do
          expect(pawn.move_valid?(move, board)).to be false
        end
      end
      context 'when moving diagonally one square forward' do
        let(:move) { Move.parse('b2 to a3') }
        it 'returns false' do
          expect(pawn.move_valid?(move, board)).to be true
        end
      end
      context 'when moving diagonally two squares forward' do
        let(:move) { Move.parse('b2 to d4') }
        it 'returns false' do
          expect(pawn.move_valid?(move, board)).to be false
        end
      end
      context 'when attempting en passant on a pawn that hasnt just moved'
      context 'when attempting en passant on a pawn that has just moved two spaces'
    end
  end
end
