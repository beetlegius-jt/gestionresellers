require "rails_helper"

RSpec.describe Product, type: :model do

  subject(:product) { FactoryGirl.build(:product) }

  ####################
  # VALIDATIONS
  ####################

  context 'is invalid' do
    after(:example) { expect(product).not_to be_valid }

    it 'without a name' do
      product.name = nil
    end

    it 'without a provider' do
      product.provider = nil
    end

    it 'without a status' do
      product.status = nil
    end

    it 'without an included status' do
      product.status = SecureRandom.hex
    end

    it 'without a price' do
      product.price = nil
    end

    it 'without a numeric price' do
      product.price = SecureRandom.hex
    end

    it 'with a negative price' do
      product.price = -100
    end

    it 'without a numeric package_price' do
      product.package_price = SecureRandom.hex
    end
  end

  it 'is valid without a package_price' do
    product.package_price = nil
    expect(product).to be_valid
  end

  ####################
  # RELATIONS
  ####################

  it 'belongs to provider' do
    expect(product).to respond_to(:provider)
  end

  ####################
  # IMAGES
  ####################

  it 'has an image', slow: true do
    expect(product).to respond_to(:image)
    product.image = File.open('app/assets/images/sample.png')
    product.save
    expect(product.image.url).to be_a_kind_of(String)
    product.image = nil
    product.save
    expect(product.image).to be_nil
  end

end
