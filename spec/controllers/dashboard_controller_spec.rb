require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  let(:client) { FactoryGirl.create(:client) }
  let(:user_client) { FactoryGirl.create(:user_client, client: client) }

  describe "GET index" do
    before(:example) { sign_in user_client }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
