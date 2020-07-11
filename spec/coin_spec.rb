require './coin.rb'
RSpec.describe Coin do
  describe '#value' do
    it 'returns the coin value' do
      coin = described_class.new(5)
      expect(coin.value).to eq 5
    end
  end
end
