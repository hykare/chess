require_relative '../lib/library'
require_relative './support/board_state_helper'

describe PawnValidation do
  let(:player) { Player.new(:white) } # only for initialization, color not checked

  describe '#piece_move_valid?' do
    context 'when moving one space forward to an empty square' do
      #  b2 -> b3
      let(:from) { Position.new(2, 'b') }
      let(:to) { Position.new(3, 'b') }
      let(:move) { Move.new(from, to) }
      let(:board) { Board.new }
      subject(:validation) { PawnValidation.new(board, move, player) }
      it 'returns true' do
        expect(validation.piece_move_valid?).to be true
      end
    end
    # needs other-than-default state setup
    context 'when moving one space forward to an occupied square' do
      it 'returns false'
    end

    context 'when moving two spaces forward from starting position, to an empty square, over an empty square' do
      # c2 -> c4
      let(:from) { Position.new(2, 'c') }
      let(:to) { Position.new(4, 'c') }
      let(:move) { Move.new(from, to) }
      let(:board) { Board.new }
      subject(:validation) { PawnValidation.new(board, move, player) }
      it 'returns true' do
        expect(validation.piece_move_valid?).to be true
      end
    end
    # needs other-than-default state setup
    context 'when moving two spaces forward from starting position, to an empty square, over an occupied square' do
      it 'returns false'
    end

    # needs other-than-default state setup
    context 'when moving two spaces forward from starting position, to an occupied square' do
      it 'returns false'
    end
    # needs other-than-default state setup
    context 'when moving two spaces forward from position other than starting' do
      it 'returns false'
    end

    context 'when moving to a different file, other than forward-diagonal squares' do
      # do two forward one to the side
      # d2 -> e4
      let(:from) { Position.new(2, 'd') }
      let(:to) { Position.new(4, 'e') }
      let(:move) { Move.new(from, to) }
      let(:board) { Board.new }
      subject(:validation) { PawnValidation.new(board, move, player) }
      it 'returns false' do
        expect(validation.piece_move_valid?).to be false
      end
    end

    context 'when moving more then two spaces forwards' do
      let(:from) { Position.new(2, 'd') }
      let(:to) { Position.new(5, 'd') }
      let(:move) { Move.new(from, to) }
      let(:board) { Board.new }
      subject(:validation) { PawnValidation.new(board, move, player) }
      it 'returns false' do
        expect(validation.piece_move_valid?).to be false
      end
    end
    # needs other-than-default state setup
    context 'when moving backwards' do
      it 'returns false'
    end

    context 'when moving to empty forward-diagonal squares' do
      let(:from) { Position.new(2, 'd') }
      let(:to) { Position.new(3, 'e') }
      let(:move) { Move.new(from, to) }
      let(:board) { Board.new }
      subject(:validation) { PawnValidation.new(board, move, player) }
      it 'returns false' do
        expect(validation.piece_move_valid?).to be false
      end
    end
    # needs other-than-default state setup
    context 'when capturing a piece in forward-diagonal squares' do
      it 'returns true'
    end
    context 'en passant'
    context 'promotion'
  end
end
