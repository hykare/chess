require_relative './support/draw_helper'
require_relative './support/board_state_helper'
require_relative '../lib/board'
require_relative '../lib/move'

describe Board do
  describe '#draw' do
    context 'when the board is empty' do
      let(:state) { empty_state }
      subject(:board) { Board.new(state) }

      it 'draws an empty board' do
        empty_board = <<~BOARD
             a b c d e f g h
          8                  8
          7                  7
          6                  6
          5                  5
          4                  4
          3                  3
          2                  2
          1                  1
             a b c d e f g h
        BOARD
        output = capture_stdout { board.draw }
        expect(remove_ansi_escapes(output)).to eq(empty_board)
      end
    end

    context 'when the game starts' do
      subject(:board) { Board.new }
      it 'draws the starting positions' do
        starting_board = <<~BOARD
             a b c d e f g h
          8 ♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜  8
          7 ♟ ♟ ♟ ♟ ♟ ♟ ♟ ♟  7
          6                  6
          5                  5
          4                  4
          3                  3
          2 ♟ ♟ ♟ ♟ ♟ ♟ ♟ ♟  2
          1 ♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜  1
             a b c d e f g h
        BOARD
        output = capture_stdout { board.draw }
        expect(remove_ansi_escapes(output)).to eq(starting_board)
      end
    end
  end

  describe '#update' do
    context 'when it gets a move' do
      let(:from) { Position.new(2, 'f') }
      let(:to) { Position.new(3, 'f') }
      let(:move) { Move.new(from, to) }
      subject(:board) { Board.new }

      it 'changes the position of a piece on the board accordingly' do
        expect { board.update(move) }.to change { board.piece_at(to) }.to(board.piece_at(from))
      end
    end
  end
end
