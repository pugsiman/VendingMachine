class Coin
  attr_reader :value

  def initialize(value, symbol = '$')
    @value = value
    @symbol = symbol
  end
end
