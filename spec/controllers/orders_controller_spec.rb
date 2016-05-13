require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  it 'inherits from ProtectedController' do
    expect(subject).to be_a_kind_of(ProtectedController)
  end

  let(:order) { FactoryGirl.create(:order) }

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

  describe "GET show" do
    it "returns http success" do
      get :show, id: order.id
      expect(response).to have_http_status(:success)
    end

    it "returns html content type" do
      get :show, id: order.id
      expect(response.content_type).to eq(Mime::HTML.to_s)
    end
  end

end
