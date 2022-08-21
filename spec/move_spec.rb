require_relative '../lib/library'

describe Move do
  describe '::parse' do
    context "when passed a string in the format 'a1 to g8'" do
      let(:from) { Position.new(1, 'a') }
      let(:to) { Position.new(8, 'g') }
      it 'creates a move object from a1 to g8' do
        expect(described_class).to receive(:for).with(from, to)
        Move.parse('a1 to g8')
      end
    end
  end

  describe '#distance' do
    context 'when moving to diagonally adjacent squares' do
      let(:from) { instance_double(Position, rank: 8, file: 'a') }
      let(:to) { instance_double(Position, rank: 7, file: 'b') }
      subject(:move) { Move.new(from, to) }

      it 'returns 1' do
        expect(subject.distance).to eql 1
      end
    end
    context 'when moving diagonally across the board' do
      let(:from) { instance_double(Position, rank: 8, file: 'h') }
      let(:to) { instance_double(Position, rank: 1, file: 'a') }
      subject(:move) { Move.new(from, to) }
      it 'returns 7' do
        expect(subject.distance).to eql 7
      end
    end
    context 'when moving 3 squares left' do
      let(:from) { instance_double(Position, rank: 8, file: 'h') }
      let(:to) { instance_double(Position, rank: 8, file: 'e') }
      subject(:move) { Move.new(from, to) }
      it 'returns 7' do
        expect(subject.distance).to eql 3
      end
    end
    context 'when moving 3 squares down' do
      let(:from) { instance_double(Position, rank: 8, file: 'h') }
      let(:to) { instance_double(Position, rank: 5, file: 'h') }
      subject(:move) { Move.new(from, to) }
      it 'returns 7' do
        expect(subject.distance).to eql 3
      end
    end
  end
end
