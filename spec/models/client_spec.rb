# == Schema Information
#
# Table name: clients
#
#  id              :integer          not null, primary key
#  name            :string
#  account_balance :decimal(15, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Client, type: :model do

  subject(:client) { FactoryGirl.build(:client) }

  ####################
  # VALIDATIONS
  ####################

  describe 'is invalid' do
    after(:example) { expect(client).not_to be_valid }

    it 'without a name' do
      client.name = nil
    end

    it 'without an account_balance' do
      client.account_balance = nil
    end
  end

  ####################
  # RELATIONS
  ####################

  it 'has many orders' do
    expect(client).to respond_to(:orders)
  end

  it 'has many movements' do
    expect(client).to respond_to(:movements)
  end

  ####################
  # CALLBACKS
  ####################

  describe 'destroy all the associated' do
    subject(:client) { FactoryGirl.create(:client) }

    it 'orders after destroy' do
      10.times do
        client.orders << FactoryGirl.build(:order)
      end
      expect { client.destroy }.to change { Order.count }.by -10
    end

    it 'movements after destroy' do
      order = FactoryGirl.create(:order)
      10.times do
        client.pay order
      end
      expect { client.destroy }.to change { Movement.count }.by -10
    end
  end

  ####################
  # METHODS
  ####################

  context '#pay' do

    subject(:client) { FactoryGirl.create(:client) }
    subject(:order) { FactoryGirl.create(:order) }
    before(:example) { client.pay order }

    it 'respond to method' do
      expect(client).to respond_to(:pay)
    end

    describe 'creates a movement' do
      it 'associated to the client' do
        expect(client.movements.count).to eq(1)
      end

      it 'with the correct ammount' do
        expect(client.movements.first.ammount).to eq(-order.total_price)
      end
    end

  end

  context '#receive_payment' do

    subject(:client) { FactoryGirl.create(:client) }
    before(:example) { client.receive_payment 1000 }

    it 'respond to method' do
      expect(client).to respond_to(:receive_payment)
    end

    describe 'creates a movement' do
      it 'associated to the client' do
        expect(client.movements.count).to eq(1)
      end

      it 'with the correct ammount' do
        expect(client.movements.first.ammount).to eq(1000)
      end
    end

  end

end
