require 'rails_helper'

RSpec.describe Api::V1::InterestsController, type: :controller do

  before do
    @user = create(:user)
		@interest = @user.interests.new(name: 'new') # => false
		@interest.save
    
    headers = { 'X-User-Email' => @user.email, 'X-User-Token' => @user.authentication_token }
    request.headers.merge! headers
  end

  describe "GET index" do
    before do
      get :index, params: { user_id: @user.id }, :format => :json
    end

    it "detail success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    before do
      get :show, params: { user_id: @user.id, id: @interest.id }, :format => :json
    end

    it "detail success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    before do
      new_interest = { name: 'new_interest', user_id: @user.id }
      post :create, params: { user_id: @user.id, interest: new_interest }, :format => :json
    end

    it "detail success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT/PATCH update" do
    before do
      patch :update, params: { user_id: @user.id, id: @interest.id, interest: { name: 'new_interest' }}, :format => :json
    end

    it "detail success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE destroy" do
    before do
      delete :destroy, params: { id: @interest.id, user_id: @user.id }, :format => :json
    end

    it "detail success" do
      expect(response).to have_http_status(:success)
    end
  end
end