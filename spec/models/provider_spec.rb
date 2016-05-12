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

  describe 'has many' do
    it 'orders' do
      expect(provider).to respond_to(:orders)
    end

    it 'products' do
      expect(provider).to respond_to(:products)
    end
  end

end
