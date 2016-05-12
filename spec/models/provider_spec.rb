# == Schema Information
#
# Table name: providers
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Provider, type: :model do

  subject(:provider) { FactoryGirl.build(:provider) }

  ####################
  # VALIDATIONS
  ####################

  describe 'is invalid' do
    after(:example) { expect(provider).not_to be_valid }

    it 'without a name' do
      provider.name = nil
    end
  end

  ####################
  # RELATIONS
  ####################

  it 'has many orders' do
    expect(provider).to respond_to(:orders)
  end

  it 'has many products' do
    expect(provider).to respond_to(:products)
  end

  it 'has many users' do
    expect(provider).to respond_to(:users)
  end

  ####################
  # CALLBACKS
  ####################

  describe 'destroy all the associated' do
    subject(:provider) { FactoryGirl.create(:provider) }

    it 'users after destroy' do
      user = FactoryGirl.create(:user, role: User::PROVIDER, provider: provider)
      expect { provider.destroy }.to change { User.count }.by -1
    end
  end

end
