require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  describe "GET login" do
    before do
      @user = create(:user)
      post :login, params: { email: @user.email, password: @user.password }, :format => :json
    end

    it "login success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE logout" do
    before do
      @user = create(:user)
      headers = { 'X-User-Email' => @user.email, 'X-User-Token' => @user.authentication_token }
      request.headers.merge! headers
      delete :logout, :format => :json
    end

    it "logout success" do
      expect(response).to have_http_status(:success)
    end
  end
end