require_relative './support/draw_helper'
require_relative '../lib/board'

describe Board do
  describe '#draw' do
    context 'when the board is empty' do
      subject(:board) { Board.new }
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
  end
end
