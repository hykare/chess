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
        expect { validation.check_safe? }.not_to(change { board })
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

# from knight validation
describe Validation do
  context 'when moving a knight' do
    let(:board) { Board.new(piece_alone(Knight.new(:white), 'd5')) }
    let(:player) { Player.new(:white) }
    subject(:validation) { Validation.for(board, move, player) }

    context 'when moving two squares right and one down' do
      let(:move) { Move.parse('d5 to f4') }
      it 'returns true' do
        expect(validation.result).to be true
      end
    end

    context 'when moving two squares right' do
      let(:move) { Move.parse('d5 to f5') }
      it 'returns true' do
        expect(validation.result).to be false
      end
    end
  end
end

# from rook validation
describe Validation do
  context 'when moving a rook' do
    let(:board) { Board.new(piece_alone(Rook.new(:white), 'd5')) }
    let(:player) { Player.new(:white) }
    subject(:validation) { Validation.for(board, move, player) }

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

# from pawn validation
describe Validation do
  let(:player) { Player.new(:white) } # only for initialization, color not checked

  describe '#piece_move_valid?' do
    context 'when moving one space forward to an empty square' do
      #  b2 -> b3
      let(:from) { Position.new(2, 'b') }
      let(:to) { Position.new(3, 'b') }
      let(:move) { Move.new(from, to) }
      let(:board) { Board.new }
      subject(:validation) { described_class.new(board, move, player) }
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
      subject(:validation) { described_class.new(board, move, player) }
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
      subject(:validation) { described_class.new(board, move, player) }
      it 'returns false' do
        expect(validation.piece_move_valid?).to be false
      end
    end

    context 'when moving more then two spaces forwards' do
      let(:from) { Position.new(2, 'd') }
      let(:to) { Position.new(5, 'd') }
      let(:move) { Move.new(from, to) }
      let(:board) { Board.new }
      subject(:validation) { described_class.new(board, move, player) }
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
      subject(:validation) { described_class.new(board, move, player) }
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
