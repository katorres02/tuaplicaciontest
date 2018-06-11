require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  before do
    @user = create(:user)
    headers = { 'X-User-Email' => @user.email, 'X-User-Token' => @user.authentication_token }
    request.headers.merge! headers
  end

  describe "GET show" do
    before do
      get :show, params: { id: @user.id }, :format => :json
    end

    it "detail success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    before do
      new_user = { email: 'test@mail.com', password: '12345678', first_name: 'test' }
      post :create, params: { user: new_user }, :format => :json
    end

    it "detail success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT/PATCH update" do
    before do
      patch :update, params: { id: @user.id, user: { id: @user.id, first_name: 'new_name'} }, :format => :json
    end

    it "detail success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE destroy" do
    before do
      delete :destroy, params: { id: @user.id }, :format => :json
    end

    it "detail success" do
      expect(response).to have_http_status(:success)
    end
  end
end