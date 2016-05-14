require 'rails_helper'

feature "Nav", type: :feature do

  shared_examples 'user' do
    before do
      login_as user, scope: :user
      visit root_path
    end
    it { expect(page).to have_link('Dashboard', href: dashboard_path) }
    it { expect(page).to have_link('Products', href: products_path) }
    it { expect(page).to have_link('Orders', href: orders_path) }
    it { expect(page).to have_link('Sign out', href: destroy_user_session_path) }
  end

  context 'as client' do
    it_behaves_like 'user' do
      let(:user) { FactoryGirl.create(:user_client) }
    end
  end

  context 'as provider' do
    it_behaves_like 'user' do
      let(:user) { FactoryGirl.create(:user_provider) }
    end
  end

  context 'as visitor' do
    before { visit root_path }

    it { expect(page).not_to have_link('Dashboard', href: dashboard_path) }
    it { expect(page).not_to have_link('Products', href: products_path) }
    it { expect(page).not_to have_link('Orders', href: orders_path) }
    it { expect(page).not_to have_link('Sign out', href: destroy_user_session_path) }
  end

end
