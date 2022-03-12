require 'rails_helper'

RSpec.describe "Users", type: :request do
  before :each do
    @user = create(:user)
    post '/login', params: { user: { email: @user.email, password: @user.password } }
    @token = JSON.parse(response.body)["token"]
  end
  describe "GET /show" do
    it "shows the current user" do
      get '/user', params: {}, headers: { "Auth-Token": @token }
      expect(JSON.parse(response.body)["id"]).to eql @user.id
    end
  end
  describe "PUT /update" do
    it "updates the current user name" do
      expect {
        put "/user", params: { user: { name: "test_update"} }, headers: { "Auth-Token": @token }
      }.to change { User.find(@user.id).name }.from(@user.name).to("test_update")
    end
  end
  describe "DELETE /delete" do
    it "deletes the current user" do
      expect {
        delete "/user", params: {}, headers: { "Auth-Token": @token }
      }.to change { User.count }.by(-1)
    end
  end
end
