require 'rails_helper'

feature "Dashboard", type: :feature do
  let(:provider) { FactoryGirl.create(:provider) }
  let(:client) { FactoryGirl.create(:client) }
  let(:user_client) { FactoryGirl.create(:user_client, client: client, provider: provider) }
  let(:user_provider) { FactoryGirl.create(:user_provider, provider: provider) }
  let(:user_admin) { FactoryGirl.create(:user_admin) }

  context 'as a client' do
    before(:example) do
      login_as user_client, scope: :user
    end

    it 'render the client template' do
      visit dashboard_path
      expect(page).to have_content(client.name)
    end

    it 'shows the current orders' do
      current_order = FactoryGirl.create :order, client: client, provider: provider, status: Order::WAITING_PAYMENT
      closed_order  = FactoryGirl.create :order, client: client, provider: provider, status: Order::CLOSED
      visit dashboard_path
      expect(page).to have_selector("#order_#{current_order.id}")
      expect(page).not_to have_selector("#order_#{closed_order.id}")
    end
  end

  context 'as a provider' do
    it 'render the provider template' do
      login_as user_provider, scope: :user
      visit dashboard_path
      expect(page).to have_content(provider.name)
    end
  end

end
