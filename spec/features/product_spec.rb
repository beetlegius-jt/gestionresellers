require 'rails_helper'

feature Product, type: :feature do
  let!(:product) { FactoryGirl.create(:product) }
  let(:user_client) { FactoryGirl.create(:user_client) }
  before(:example) { login_as user_client, scope: :user }

  describe 'Listing products' do
    it 'view its basic information' do
      visit products_path
      expect(page).to have_content(product.name)
      expect(page).to have_content(product.price)
      expect(page).to have_content(product.status)
    end

    context 'with a package price product' do
      let!(:package_product) { FactoryGirl.create(:package_product) }

      it 'views the package price' do
        visit products_path
        expect(page).to have_selector(".package-price")
        # expect(page).to have_content(package_product.package_price)
        # expect(page).to have_content(package_product.package_quantity)
      end
    end
  end

  describe 'Show product' do
    it 'view its full information' do
      visit product_path(product)
      expect(page).to have_content(product.name)
      expect(page).to have_content(product.description)
      expect(page).to have_content(product.price)
      expect(page).to have_content(product.status)
    end
  end

end
