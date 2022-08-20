require_relative '../lib/library'

describe MoveDiagonal do
  describe '#path' do
    context 'when moving to an adjacent diagonal square' do
      subject(:move) { Move.parse('d5 to e4') }
      it 'returns an empty array' do
        expect(move.path).to eql []
      end
    end
    context 'when moving three files left and three ranks down' do
      subject(:move) { Move.parse('g5 to d2') }
      let(:position1) { Position.new(4, 'f') }
      let(:position2) { Position.new(3, 'e') }
      it 'returns an array with the two inbetween positions' do
        expect(move.path.sort).to eql [position1, position2].sort
      end
    end
    context 'when moving three files right and three ranks up' do
      subject(:move) { Move.parse('d2 to g5') }
      let(:position1) { Position.new(4, 'f') }
      let(:position2) { Position.new(3, 'e') }
      it 'returns an array with the two inbetween positions' do
        expect(move.path.sort).to eql [position1, position2].sort
      end
    end
  end
end
