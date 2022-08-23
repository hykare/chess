require_relative '../lib/library'
require_relative './support/board_state_helper'

describe Validation do
  describe '#start_position_valid?' do
    let(:move) { instance_double(Move) }
    let(:board) { instance_double(Board) }
    let(:moved_piece) { instance_double(Piece) }
    let(:player) { instance_double(Player) }
    subject(:validation) { described_class.new(board, move, player) }

    context 'when passed a correct move' do
      before do
        allow(move).to receive(:from)
        allow(board).to receive(:piece_at).and_return(moved_piece)
        allow(moved_piece).to receive(:player_color).and_return(:white)
        allow(player).to receive(:color).and_return(:white)
      end
      it 'returns true' do
        expect(validation.start_position_valid?).to be true
      end
    end

    context 'when passed a move from outside the board' do
      before do
        allow(move).to receive(:from)
        allow(board).to receive(:piece_at).and_return(nil)
        allow(player).to receive(:color).and_return(:white)
      end
      it 'returns false' do
        expect(validation.start_position_valid?).to be false
      end
    end

    context 'when trying to move the opponents piece' do
      before do
        allow(move).to receive(:from)
        allow(board).to receive(:piece_at).and_return(moved_piece)
        allow(moved_piece).to receive(:player_color).and_return(:black)
        allow(player).to receive(:color).and_return(:white)
      end
      it 'returns false' do
        expect(validation.start_position_valid?).to be false
      end
    end

    context "when there's no piece in the starting position" do
      before do
        allow(move).to receive(:from)
        allow(board).to receive(:piece_at).and_return(nil)
        allow(player).to receive(:color).and_return(:white)
      end
      it 'returns false' do
        expect(validation.start_position_valid?).to be false
      end
    end
  end

  describe '#target_position_valid?' do
    let(:position) { instance_double(Position) }
    let(:move) { instance_double(Move) }
    let(:board) { instance_double(Board) }
    let(:target_piece) { instance_double(Piece) }
    let(:player) { instance_double(Player) }
    subject(:validation) { described_class.new(board, move, player) }

    context 'when moving to an empty tile' do
      before do
        allow(move).to receive(:to).and_return(position)
        allow(position).to receive(:valid?).and_return(true)
        allow(board).to receive(:piece_at).and_return(nil)
        allow(player).to receive(:color).and_return(:white)
      end
      it 'returns true' do
        expect(validation.target_position_valid?).to be true
      end
    end

    context "when moving to a tile with the opponent's piece" do
      before do
        allow(move).to receive(:to).and_return(position)
        allow(position).to receive(:valid?).and_return(true)
        allow(board).to receive(:piece_at).and_return(target_piece)
        allow(target_piece).to receive(:player_color).and_return(:black)
        allow(player).to receive(:color).and_return(:white)
      end
      it 'returns true' do
        expect(validation.target_position_valid?).to be true
      end
    end

    context 'when passed a move going outside of the board' do
      before do
        allow(move).to receive(:to).and_return(position)
        allow(position).to receive(:valid?).and_return(false)
      end
      it 'returns false' do
        expect(validation.target_position_valid?).to be false
      end
    end

    context 'when the target position already has your own piece' do
      before do
        allow(move).to receive(:to).and_return(position)
        allow(position).to receive(:valid?).and_return(true)
        allow(board).to receive(:piece_at).and_return(target_piece)
        allow(target_piece).to receive(:player_color).and_return(:white)
        allow(player).to receive(:color).and_return(:white)
      end
      it 'returns false' do
        expect(validation.target_position_valid?).to be false
      end
    end
  end

  describe '#piece_move_valid?' do
  end

  describe '#check_safe?' do
    context 'when move would place your own king in check' do
      let(:board) { Board.new(white_rook_pin) }
      let(:move) { Move.parse('d3 to f3') }
      let(:player) { Player.new(:white) }
      subject(:validation) { Validation.new(board, move, player) }

      it 'returns false' do
        expect(validation.check_safe?).to be false
      end

      it "doesn't change board state" do
        expect { validation.check_safe? }.not_to(change { board.state })
      end
    end

    context "when move doesn't leave your king in check" do
      let(:board) { Board.new(white_rook_pin) }
      let(:move) { Move.parse('d3 to d4') }
      let(:player) { Player.new(:white) }
      subject(:validation) { Validation.new(board, move, player) }
      it 'returns true' do
        expect(validation.check_safe?).to be true
      end
    end
  end
end
