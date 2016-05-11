require "rails_helper"

RSpec.describe Product, type: :model do

  # let(:provider) { FactoryGirl.build(:provider) }
  subject(:product) { FactoryGirl.build(:product) }
  let(:package_product) { FactoryGirl.build(:package_product) }

  it 'is invalid without a name' do
    product.name = nil
    expect(product).not_to be_valid
  end

  it 'is invalid without a provider' do
    product.provider = nil
    expect(product).not_to be_valid
  end

end
