# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  unit_price :decimal(15, 2)
#  quantity   :integer          default(1)
#  product_id :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Item, type: :model do

  subject(:item) { FactoryGirl.build(:item) }

  ####################
  # VALIDATIONS
  ####################

  describe 'is invalid' do
    after(:example) { expect(item).not_to be_valid }

    it 'without a product' do
      item.product = nil
    end

    it 'without an order' do
      item.order = nil
    end

    it 'without a quantity' do
      item.quantity = nil
    end

    it 'without a numerical quantity' do
      item.quantity = SecureRandom.hex
    end

    it 'with a negative quantity' do
      item.quantity = -1
    end

    it 'with a zero quantity' do
      item.quantity = 0
    end

    it 'without an unit price' do
      item.unit_price = nil
    end

    it 'without a numerical unit price' do
      item.unit_price = SecureRandom.hex
    end

    it 'with a negative unit price' do
      item.unit_price = -1
    end
  end

  ####################
  # RELATIONS
  ####################

  it 'belongs to order' do
    expect(item).to respond_to(:order)
  end

  it 'belongs to product' do
    expect(item).to respond_to(:product)
  end

  ####################
  # METHODS
  ####################

  context '#price' do
    it 'calculates the total price' do
      expect(item).to respond_to(:price)

      total_price = item.unit_price * item.quantity
      expect(item.price).to eq(total_price)
    end
  end

end
