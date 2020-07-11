require './product.rb'
RSpec.describe Product do
  subject { described_class.new('bamba', 3) }

  describe '#name' do
    it 'returns the product name' do
      expect(subject.name).to eq 'bamba'
    end
  end

  describe '#price' do
    it 'returns the product price' do
      expect(subject.price).to eq 3
    end
  end
end
