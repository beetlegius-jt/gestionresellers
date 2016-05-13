require 'rails_helper'

feature "Session", type: :feature, focus: true do
  let(:user_client) { FactoryGirl.create(:user_client) }
  let(:user_provider) { FactoryGirl.create(:user_client) }
  let(:user_admin) { FactoryGirl.create(:user_client) }

  it 'can signin' do
    visit new_user_session_path
    within '#new_user' do
      fill_in 'user_email', with: user_client.email
      fill_in 'user_password', with: user_client.password
      click_on 'Log in'
    end
  end

end
