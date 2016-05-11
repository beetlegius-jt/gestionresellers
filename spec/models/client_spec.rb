require 'rails_helper'

RSpec.describe Client, type: :model do

  subject(:client) { FactoryGirl.build(:client) }

  ####################
  # VALIDATIONS
  ####################

  context 'is invalid' do
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

end
