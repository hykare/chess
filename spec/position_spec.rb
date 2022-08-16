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
end
