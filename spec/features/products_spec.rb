require 'rails_helper'

feature "Products", type: :feature do
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
