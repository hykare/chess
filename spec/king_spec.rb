require_relative '../lib/library'
require_relative './support/board_state_helper'

describe King do
  describe '#valid_castling?' do
    let(:board) { Board.new(castlemania) }
    let(:white_king) { board.piece_at(Position.parse('e1')) }
    let(:black_king) { board.piece_at(Position.parse('e8')) }
    let(:white_queenside_rook) { board.piece_at(Position.parse('a1')) }

    context 'when castling kingside' do
      let(:move) { Move.parse('e1 to g1') }
      it 'returns true' do
        expect(white_king.valid_castling?(move, board)).to be true
      end
    end

    context 'when castling queenside' do
      let(:move) { Move.parse('e1 to c1') }
      it 'returns true' do
        expect(white_king.valid_castling?(move, board)).to be true
      end
    end

    context 'when there is no rook' do
      let(:move) { Move.parse('e8 to g8') }
      it 'returns false' do
        expect(black_king.valid_castling?(move, board)).to be false
      end
    end

    context 'when the rook has moved before' do
      let(:move) { Move.parse('e1 to c1') }
      before do
        white_queenside_rook.has_moved = true
      end
      it 'returns false' do
        expect(white_king.valid_castling?(move, board)).to be false
      end
    end

    context 'when the king has moved before' do
      let(:move) { Move.parse('e1 to c1') }
      before do
        white_king.has_moved = true
      end
      it 'returns false' do
        expect(white_king.valid_castling?(move, board)).to be false
      end
    end

    context 'when there is a piece between king and rook' do
      let(:move) { Move.parse('e1 to c1') }
      before do
        board.state[Position.parse('b1')] = Knight.new(:white)
      end
      it 'returns false' do
        expect(white_king.valid_castling?(move, board)).to be false
      end
    end

    context "when the king's path is under attack" do
      let(:move) { Move.parse('e1 to c1') }
      before do
        board.state[Position.parse('h5')] = Bishop.new(:black)
      end
      it 'returns false' do
        expect(white_king.valid_castling?(move, board)).to be false
      end
    end

    context "when the king's path is under attack by a pawn" do
      let(:move) { Move.parse('e1 to c1') }
      before do
        board.state[Position.parse('c2')] = Pawn.for(:black)
      end
      xit 'returns false' do
        expect(white_king.valid_castling?(move, board)).to be false
      end
    end

    context 'when the king is in check' do
      let(:move) { Move.parse('e1 to c1') }
      before do
        board.state[Position.parse('h4')] = Bishop.new(:black)
      end
      it 'returns false' do
        expect(white_king.valid_castling?(move, board)).to be false
      end
    end
  end
end
