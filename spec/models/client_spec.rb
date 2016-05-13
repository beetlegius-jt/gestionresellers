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

RSpec.describe Client, type: :model, focus: true do

  subject!(:client) { FactoryGirl.create(:client) }

  it 'account balance starts empty' do
    expect(client.account_balance).to be_zero
  end

  ####################
  # VALIDATIONS
  ####################

  describe 'is invalid' do
    subject(:client) { FactoryGirl.build(:client) }
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

  it 'has many users' do
    expect(client).to respond_to(:users)
  end

  ####################
  # CALLBACKS
  ####################

  describe 'destroy all the associated' do

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

    it 'users after destroy' do
      user = FactoryGirl.create(:user, role: User::CLIENT, client: client)
      expect { client.destroy }.to change { User.count }.by -1
    end
  end

  ####################
  # METHODS
  ####################

  context '#pay' do

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

  context '#main_user' do
    let!(:user1) { FactoryGirl.create(:user_client, client: client) }
    let!(:user2) { FactoryGirl.create(:user_client, client: client) }
    let!(:user3) { FactoryGirl.create(:user_client, client: client) }

    it 'respond to method' do
      expect(client).to respond_to(:main_user)
    end

    it 'returns the first user' do
      expect(client.main_user).to eq(user1)
    end
  end

end
