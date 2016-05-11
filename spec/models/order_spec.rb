require 'rails_helper'

RSpec.describe Order, type: :model do

  subject(:order) { FactoryGirl.build(:order) }

  ####################
  # VALIDATIONS
  ####################

  context 'is invalid' do
    after(:example) { expect(order).not_to be_valid }

    it 'without a client' do
      order.client = nil
    end

    it 'without a provider' do
      order.provider = nil
    end

    it 'without a status' do
      order.status = nil
    end

    it 'without an included status' do
      order.status = SecureRandom.hex
    end

    it 'without a numeric total_price' do
      order.total_price = SecureRandom.hex
    end

    it 'without a negative total_price' do
      order.total_price = -100
    end
  end

  ####################
  # RELATIONS
  ####################

  context 'belongs to' do
    it 'client' do
      expect(order).to respond_to(:client)
    end

    it 'provider' do
      expect(order).to respond_to(:provider)
    end
  end

end
