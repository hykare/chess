require_relative '../lib/library'

describe MoveVertical do
  describe '#path' do
    context 'when moving to an adjacent rank' do
      subject(:move) { Move.parse('d5 to d6') }
      it 'returns an empty array' do
        expect(move.path).to eql []
      end
    end
    context 'when moving three ranks up' do
      subject(:move) { Move.parse('d5 to d8') }
      let(:position1) { Position.new(6, 'd') }
      let(:position2) { Position.new(7, 'd') }
      it 'returns an array with the two inbetween positions' do
        expect(move.path.sort).to eql [position1, position2].sort
      end
    end
    context 'when moving three ranks down' do
      subject(:move) { Move.parse('d8 to d5') }
      let(:position1) { Position.new(6, 'd') }
      let(:position2) { Position.new(7, 'd') }
      it 'returns an array with the two inbetween positions' do
        expect(move.path.sort).to eql [position1, position2].sort
      end
    end
  end
end
