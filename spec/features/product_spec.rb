require 'rails_helper'

feature Product, type: :feature do
  let(:provider) { FactoryGirl.create(:provider) }
  let(:user_client) { FactoryGirl.create(:user_client, provider: provider) }
  let(:product) { FactoryGirl.build(:product, provider: provider) }

  before(:example) { login_as user_client, scope: :user }

  describe 'Listing products' do
    it 'view its basic information' do
      product.save
      visit products_path
      expect(page).to have_content(product.name)
      expect(page).to have_content(product.price)
      expect(page).to have_content(product.status)
    end

    context 'with a package price product' do
      let(:package_product) { FactoryGirl.build(:package_product, provider: provider) }

      it 'views the package price' do
        package_product.save
        visit products_path
        expect(page).to have_selector(".package-price")
      end
    end

    it 'search products' do
      product.save
      visit products_path

      fill_in 'search', with: product.name
      click_button 'Search'
      expect(page).to have_selector("#product_#{product.id}")

      fill_in 'search', with: SecureRandom.hex
      click_button 'Search'
      expect(page).not_to have_selector("#product_#{product.id}")
    end

    it 'paginates with 10 products per page' do
      25.times { FactoryGirl.create(:product, provider: provider) }

      visit products_path
      provider.products.limit(10).each            { |product| expect(page).to     have_selector("#product_#{product.id}") }
      provider.products.offset(10).each           { |product| expect(page).not_to have_selector("#product_#{product.id}") }

      click_link 'Next'
      provider.products.limit(10).each            { |product| expect(page).not_to have_selector("#product_#{product.id}") }
      provider.products.offset(10).limit(10).each { |product| expect(page).to     have_selector("#product_#{product.id}") }
      provider.products.offset(20).each           { |product| expect(page).not_to have_selector("#product_#{product.id}") }
    end
  end

  describe 'Show product' do
    let(:product) { FactoryGirl.create(:product, provider: provider) }

    it 'view its full information' do
      visit product_path(product)
      expect(page).to have_content(product.name)
      expect(page).to have_content(product.description)
      expect(page).to have_content(product.price)
      expect(page).to have_content(product.status)
    end
  end

end
