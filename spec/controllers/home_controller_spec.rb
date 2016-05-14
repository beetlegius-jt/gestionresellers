require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  let(:user_client) { FactoryGirl.create(:user_client) }
  let(:user_provider) { FactoryGirl.create(:user_provider) }
  let(:user_admin) { FactoryGirl.create(:user_admin) }

  describe "GET index" do

    context 'as visitor' do
      before(:example) { sign_out :user }
      
      it "returns http code 200" do
        get :index
        expect(response).to have_http_status(200)
      end

      it "returns html content type" do
        get :index
        expect(response.content_type).to eq(Mime::HTML.to_s)
      end
    end

    context 'as a client' do
      before(:example) { sign_in user_client }

      it "returns http code 302" do
        get :index
        expect(response).to have_http_status(302)
      end

      it 'redirects me to my dashboard' do
        get :index
        expect(response).to redirect_to(dashboard_url)
      end
    end

    context 'as a provider' do
      before(:example) { sign_in user_provider }

      it "returns http code 302" do
        get :index
        expect(response).to have_http_status(302)
      end

      it 'redirects me to my dashboard' do
        get :index
        expect(response).to redirect_to(dashboard_url)
      end
    end

    context 'as an admin' do
      pending 'redirects me to the admin panel'
    end

  end

end
