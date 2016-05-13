require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  let(:user_client) { FactoryGirl.create(:user_client) }
  before(:example) { sign_in user_client }

  describe "GET index" do

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns html content type" do
      get :index
      expect(response.content_type).to eq(Mime::HTML.to_s)
    end

  end

end
