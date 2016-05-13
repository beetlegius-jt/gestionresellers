require 'rails_helper'

RSpec.describe ClientsController, type: :controller do

  subject!(:client) { FactoryGirl.create(:client) }
  let!(:user) { FactoryGirl.create(:user_client, client: client) }

  describe "GET dashboard" do

    before(:example) do
      sign_in client.main_user
    end

    it "returns http success" do
      get :dashboard
      expect(response).to have_http_status(:success)
    end
  end

end
