require 'rails_helper'

feature "Dashboard", type: :feature do
  let(:user_client) { FactoryGirl.create(:user_client) }
  let(:user_provider) { FactoryGirl.create(:user_provider) }
  let(:user_admin) { FactoryGirl.create(:user_admin) }

  context 'as a client' do
    it 'render the client template' do
      login_as user_client, scope: :user
      visit dashboard_path
      expect(page).to have_content(user_client.client.name)
    end
  end

  context 'as a provider' do
    it 'render the provider template' do
      login_as user_provider, scope: :user
      visit dashboard_path
      expect(page).to have_content(user_provider.provider.name)
    end
  end

end
