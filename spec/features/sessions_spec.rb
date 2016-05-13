require 'rails_helper'

feature "Sessions", type: :feature do
  subject(:client) { FactoryGirl.create(:client) }
  let!(:user) { FactoryGirl.create(:user_client, client: client) }

  context 'valid client session' do
    before(:example) { sign_in user }

    pending 'redirects me to my dashboard'
  end

  context 'with an invalid client session' do
    pending 'shows me the form again and list errors'
  end

end
