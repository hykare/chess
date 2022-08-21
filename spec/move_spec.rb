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
end
