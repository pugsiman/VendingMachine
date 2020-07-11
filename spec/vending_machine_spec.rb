require './vending_machine.rb'
require './product.rb'
require './coin.rb'
require 'pry'

RSpec.describe VendingMachine do
  let(:products_mock) { [Product.new('a', 5), Product.new('expensive_product', 500), Product.new('c', 0.5), Product.new('c', 0.1)] }
  let(:coins_mock) do
    mock = []
    5.times { mock << Coin.new(5) }
    10.times { mock << Coin.new(0.25) }
    mock
  end

  subject { described_class.new(products: products_mock, coins: coins_mock) }

  describe '#insert_coin' do
    it 'adds a coin object to the vending machine coins cell' do
      expect { subject.insert_coin(Coin.new(1)) }.to change { subject.coin_cell }.from([])
    end
  end

  describe '#release_coins' do
    it 'removes the coins from the coins cell' do
      subject.insert_coin(Coin.new(1))
      expect { subject.release_coins }.to change { subject.coin_cell }.to([])
    end
  end

  describe '#select_product' do
    context 'when selected product is unavailable' do
      it 'returns a message and doesn\'t purchase it' do
        expect(subject.select_product('unavailable_product')).to eq subject.send(:no_service_message)
      end
    end

    context 'when selected product is available' do
      context 'when not enough money was inserted for product' do
        it 'returns not enough coins inserted message' do
          subject.insert_coin(Coin.new(1))
          expect(subject.select_product('b')).to eq subject.send(:not_enough_coins_message)
        end
      end

      context 'when enough money was inserted for product' do
        before do
          subject.insert_coin(Coin.new(5))
          subject.insert_coin(Coin.new(1))
        end

        it 'returns the product with the proper change' do
          result = subject.select_product('a')
          expect(result).to be_a Hash
          expect(result).to include(product: a_kind_of(Product), change: a_kind_of(Array))
        end

        context 'when not enough coins exist for change' do
          let(:coins_mock) { [Coin.new(0.25)] }
          subject { described_class.new(products: products_mock, coins: coins_mock) }

          it 'returns no service message' do
            expect(subject.select_product('a')).to eq subject.send(:no_service_message)
          end
        end
      end
    end
  end
end
