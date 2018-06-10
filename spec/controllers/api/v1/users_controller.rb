require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  before do
    @user = create(:user)
  end

  describe "GET show" do
    before do
      headers = { 'X-User-Email' => @user.email, 'X-User-Token' => @user.authentication_token }
      request.headers.merge! headers
      get :show, params: { id: @user.id }, :format => :json
    end

    it "detail success" do
      expect(response).to have_http_status(:success)
    end
  end

end