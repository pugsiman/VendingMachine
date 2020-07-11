class VendingMachine
  attr_reader :coin_cell

  def initialize(products: [], coins: [])
    @products = products
    @coins = coins
    @coin_cell = []
  end

  def select_product(product_name)
    if stock_available? && coins_available?
      found_product = @products.find { |product| product.name == product_name }
      return no_service_message unless found_product

      return purchase_product(found_product) if product_purchasable?(found_product)

      not_enough_coins_message
    else
      no_service_message
    end
  end

  def insert_coin(coin)
    @coin_cell << coin
  end

  def release_coins
    puts @coin_cell
    @coin_cell.clear
  end

  private

  def purchase_product(selected_product)
    product_index = @products.index { |product| product.name == selected_product.name }
    change_amount = calculate_change_amount(@products[product_index])
    change = collect_change_by_amount(change_amount)

    return no_service_message if money_sum(change) < change_amount

    product = @products.slice!(product_index)

    @coins += @coin_cell
    @coin_cell.clear

    {
      product: product,
      change: change
    }.tap { |purchase| p purchase }
  end

  def product_purchasable?(product)
    money_sum(@coin_cell) >= product.price
  end

  def money_sum(coins)
    return 0 if coins.empty?

    coins.map(&:value).reduce(:+)
  end

  def stock_available?
    !@products.empty?
  end

  def coins_available?
    !@coins.empty?
  end

  def calculate_change_amount(product)
    sum = money_sum(@coin_cell)
    change = sum - product.price
    change.positive? ? change : 0
  end

  def collect_change_by_amount(amount)
    collected_coins = []
    return collected_coins if amount.zero?

    remaining_amount = amount
    @coins.each do |coin|
      coin_value = coin.value
      next unless (remaining_amount / coin_value).positive?

      (remaining_amount / coin_value).to_i.times do
        break unless @coins.find { |c| c == coin }

        collected_coins << coin

        @coins.reject! { |coin_for_removal| coin_for_removal == coin }
      end

      remaining_amount = amount - money_sum(collected_coins)
    end

    collected_coins
  end

  def no_service_message
    puts 'The machine cannot serve you currently, please contact the owner'
  end

  def not_enough_coins_message
    puts 'could not provide product, please make sure enough coins were inserted'
  end
end
