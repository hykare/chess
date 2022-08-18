require_relative '../lib/position'

describe Position do
  describe '#all' do
    it 'returns an array of 64 positions' do
      expect(described_class.all.length).to be 64
    end
    it 'contains no duplicates' do
      expect(described_class.all.uniq).to eql described_class.all
    end
    it 'is ordered left-to-right, top-to-bottom' do
      expect(described_class.all[0].to_s).to eql 'a8'
      expect(described_class.all[1].to_s).to eql 'b8'
    end
  end

  describe '#parse' do
    context 'when passed a string' do
      it 'returns a position object' do
        expect(described_class.parse('g7')).to eql Position.new(7, 'g')
      end
    end
  end

  describe '#valid?' do
    context 'when passed a position within the board' do
      subject(:position) { described_class.new(8, 'a') }
      it 'returns true' do
        expect(position).to be_valid
      end
    end
    context 'when passed a file outside of the board' do
      subject(:position) { described_class.new(4, 'z') }
      it 'returns false' do
        expect(position).not_to be_valid
      end
    end
    context 'when passed a rank outside of the board' do
      subject(:position) { described_class.new(9, 'b') }
      it 'returns false' do
        expect(position).not_to be_valid
      end
    end
  end
end
