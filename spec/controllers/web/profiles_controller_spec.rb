require 'rails_helper'

RSpec.describe Web::ProfilesController, type: :controller do

  describe "GET #edit" do
    it "returns http success" do
      sign_in create(:user)
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    it "returns http success" do
      sign_in create(:user)
      patch :update, profile: {first_name: 'Pop', last_name: 'Eye'}
      expect(subject).to redirect_to('/profile')
    end
  end
end
