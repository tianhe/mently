require 'rails_helper'

RSpec.describe Web::PreferencesController, type: :controller do
  describe "GET #show" do    
    it "returns http success when logged in" do
      sign_in create(:user)
      get :show
      expect(response).to have_http_status(:success)
    end

    it "redirects to / when it cant find user" do
      sign_in nil
      get :show
      expect(subject).to redirect_to('/')
    end
  end
end
