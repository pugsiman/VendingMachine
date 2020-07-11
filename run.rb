require './coin.rb'
require './product.rb'
require './vending_machine.rb'

PRODUCTS_STOCK = [Product.new('bamba', 2)] * 10 + [Product.new('doritos', 3)] * 10
COINS_STOCK = [
  Coin.new(1), Coin.new(0.25), Coin.new(0.5), Coin.new(2), Coin.new(5),
  Coin.new(1), Coin.new(0.25), Coin.new(0.5), Coin.new(2), Coin.new(5),
  Coin.new(1), Coin.new(0.25), Coin.new(0.5), Coin.new(2), Coin.new(5),
  Coin.new(1), Coin.new(0.25), Coin.new(0.5), Coin.new(2), Coin.new(5),
  Coin.new(1), Coin.new(0.25), Coin.new(0.5), Coin.new(2), Coin.new(5)
]

vending_machine = VendingMachine.new(products: PRODUCTS_STOCK, coins: COINS_STOCK)

vending_machine.insert_coin(Coin.new(0.5))
vending_machine.insert_coin(Coin.new(2))
vending_machine.select_product('bamba')

vending_machine.insert_coin(Coin.new(2))
vending_machine.select_product('doritos')

vending_machine.select_product('bagels')
