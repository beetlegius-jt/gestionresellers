require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  subject(:shopping_cart) { ShoppingCart.new }
  let(:product1) { FactoryGirl.create(:product) }
  let(:product2) { FactoryGirl.create(:product) }

  it 'has items' do
    expect(shopping_cart).to respond_to(:items)
  end

  it 'has total price' do
    expect(shopping_cart).to respond_to(:total_price)
  end

  it 'can set items', refactor: true do
    expect { shopping_cart.set_item(product1) }.to change { shopping_cart.items.size }.by 1
  end

  it 'can remove items', refactor: true do
    shopping_cart.set_item(product1)
    expect { shopping_cart.remove_item(product1) }.to change { shopping_cart.items.size }.by -1
  end

  it 'calculates the total price', refactor: true do
    shopping_cart.set_item(product1, 3)
    shopping_cart.set_item(product2)

    total_price = product1.price * 3 + product2.price
    expect(shopping_cart.total_price).to eq(total_price)
  end

end
