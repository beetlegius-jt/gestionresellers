require 'spec_helper'

RSpec.describe ProductDecorator, type: :decorator do
  let(:product) { FactoryGirl.create(:product).decorate }
  let(:package_product) { FactoryGirl.create(:package_product).decorate }

  context '#package_label' do
    it 'responds to method' do
      expect(package_product).to respond_to(:package_label)
    end

    it 'returns the correct message' do
      package_product.package_price = 100
      package_product.package_quantity = 20
      expect(package_product.package_label).to eq("multiples of 20, $100.00 each")
    end
  end

end
