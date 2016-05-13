require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  let(:user_client) { FactoryGirl.create(:user_client) }
  let(:user_provider) { FactoryGirl.create(:user_provider) }
  let(:user_admin) { FactoryGirl.create(:user_admin) }

  describe "GET index" do

    it "returns http code 302" do
      get :index
      expect(response).to have_http_status(302)
    end

    context 'as visitor' do
      it 'redirects me to the new session path' do
        get :index
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context 'as a client' do
      it 'redirects me to my dashboard' do
        sign_in user_client
        get :index
        expect(response).to redirect_to(dashboard_url)
      end
    end

    context 'as a provider' do
      it 'redirects me to my dashboard' do
        sign_in user_provider
        get :index
        expect(response).to redirect_to(dashboard_url)
      end
    end

    context 'as an admin' do
      pending 'redirects me to the admin panel'
    end

  end

end
