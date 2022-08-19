require_relative '../lib/validation'
require_relative '../lib/board'
require_relative '../lib/position'
require_relative '../lib/move'
require_relative '../lib/player'

describe Validation do
  describe '#start_position_valid?' do
    context 'when passed a correct move' do
      let(:move) { instance_double(Move) }
      let(:board) { instance_double(Board) }
      let(:white_piece) { instance_double(Piece) }
      let(:player) { instance_double(Player) }

      subject(:validation) { described_class.new(board, move, player) }

      before do
        allow(move).to receive(:from)
        allow(board).to receive(:piece_at).and_return(white_piece)
        allow(white_piece).to receive(:player_color).and_return(:white)
        allow(player).to receive(:color).and_return(:white)

        allow(validation).to receive(:evaluate)
      end

      it 'returns true' do
        expect(validation.start_position_valid?).to be true
      end
    end
    context 'when passed a move from outside the board' do
      it 'returns false'
    end
    context 'when trying to move the opponents piece' do
      it 'returns false'
    end
    context "when there's no piece in the starting position" do
      it 'returns false'
    end
  end

  describe '#target_position_valid?' do
    context 'when passed a correct move' do
      it 'returns true'
    end
    context 'when passed a move going outside of the board' do
      it 'returns false'
    end
    context 'when the target position already has your own piece' do
      it 'returns false'
    end
  end

  describe '#piece_move_valid?'

end
