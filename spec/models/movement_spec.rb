# == Schema Information
#
# Table name: movements
#
#  id         :integer          not null, primary key
#  ammount    :decimal(15, 2)
#  order_id   :integer
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Movement, type: :model do

  subject(:movement) { FactoryGirl.build(:movement) }

  ####################
  # VALIDATIONS
  ####################

  describe 'is invalid' do
    after(:example) { expect(movement).not_to be_valid }

    it 'without a client' do
      movement.client = nil
    end

    it 'without an ammount' do
      movement.ammount = nil
    end

    it 'without a numeric ammount' do
      movement.ammount = SecureRandom.hex
    end
  end

  it 'is not invalid without an order' do
    movement.order = nil
    expect(movement).to be_valid
  end

  ####################
  # RELATIONS
  ####################

  it 'belongs to client' do
    expect(movement).to respond_to(:client)
  end

  it 'belongs to order' do
    expect(movement).to respond_to(:order)
  end

  ####################
  # CALLBACKS
  ####################

  describe 'updates the account_balance of the client' do
    it 'after create' do
      expect { movement.save }.to change { movement.client.account_balance }.by movement.ammount
    end

    it 'after destroy' do
      movement = FactoryGirl.create(:movement)
      expect { movement.destroy }.to change { movement.client.account_balance }.by -movement.ammount
    end
  end

end
