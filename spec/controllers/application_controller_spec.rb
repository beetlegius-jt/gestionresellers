require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  let(:user) { FactoryGirl.create(:user_client) }

  describe "GET index" do

    context 'with an undefined session' do

      it "returns http code 302" do
        get :index
        expect(response).to have_http_status(302)
      end

      it 'redirects me to the new session path' do
        expect(subject.current_user).to be_nil
        get :index
        expect(response.location).to eq(new_user_session_url)
      end
    end

  end

end
