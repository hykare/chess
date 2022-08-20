require_relative '../lib/library'

describe MoveHorizontal do
  describe '#path' do
    context 'when moving to an adjacent file' do
      subject(:move) { Move.parse('d5 to e5') }
      it 'returns an empty array' do
        expect(move.path).to eql []
      end
    end
    context 'when moving three files to the right' do
      subject(:move) { Move.parse('d5 to g5') }
      let(:position1) { Position.new(5, 'e') }
      let(:position2) { Position.new(5, 'f') }
      it 'returns an array with the two inbetween positions' do
        expect(move.path.sort).to eql [position1, position2].sort
      end
    end
    context 'when moving three files to the left' do
      subject(:move) { Move.parse('g5 to d5') }
      let(:position1) { Position.new(5, 'e') }
      let(:position2) { Position.new(5, 'f') }
      it 'returns an array with the two inbetween positions' do
        expect(move.path.sort).to eql [position1, position2].sort
      end
    end
  end
end
