class ShoppingCart
  include ActiveModel::Model

  attr_accessor :items, :total_price

  def initialize
    @items = {}
  end

  def set_item(product, quantity = 1)
    @items[product.name] = { quantity: quantity, price: product.price }
  end

  def remove_item(product)
    @items.delete product.name
  end

  def total_price
    @items.map { |product_name, item| item[:price] * item[:quantity] }.sum
  end

end
