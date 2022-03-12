require 'rails_helper'

RSpec.describe "Wallets", type: :request do
  before :each do
    @user = create(:user, user_type: 0)
    @wallet = @user.create_wallet(balance: 0)
    post '/login', params: { user: { email: @user.email, password: @user.password } }
    @token = JSON.parse(response.body)["token"]
  end
  describe "GET /show" do
    it "should return the user's wallet" do
      get "/user/wallet", params: {}, headers: { "Auth-Token": @token }
      expect(JSON.parse(response.body)).to include("balance")
    end
  end
  describe "PUT /update" do
    it "should fail if a negative value is passed to balance" do
      put "/user/wallet", params: { wallet: { balance: -1 } }, headers: { "Auth-Token": @token }
      expect(response.status).to eql(422)
    end
    it "should update the wallet balance" do
      expect {
        put "/user/wallet", params: { wallet: { balance: 50 } }, headers: { "Auth-Token": @token }
      }.to change { Wallet.find(@wallet.id).balance }.from(0).to(50)
    end
  end
end
