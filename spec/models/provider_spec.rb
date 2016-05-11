require 'rails_helper'

RSpec.describe Provider, type: :model do

  subject(:provider) { FactoryGirl.build(:provider) }

  it 'is invalid without a name' do
    provider.name = nil
    expect(provider).not_to be_valid
  end

end
