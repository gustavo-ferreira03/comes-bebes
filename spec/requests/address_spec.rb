require 'rails_helper'

RSpec.describe "Addresses", type: :request do
  before :each do
    @user = create(:user, user_type: 0)
    @address = @user.addresses.create(attributes_for(:address))
    post '/login', params: { user: { email: @user.email, password: @user.password } }
    @token = JSON.parse(response.body)["token"]
  end
  describe "GET /index" do
    before :each do
      2.times { @user.addresses.create(attributes_for(:address)) }
    end
    it "returns all of the user's addresses" do
      get "/user/addresses", params: {}, headers: { "Auth-Token": @token }
      expect(JSON.parse(response.body).count).to eql(3)
    end
  end
  describe "GET /show" do
    it "shows a user address" do
      get "/user/addresses/#{@address.id}", params: {}, headers: { "Auth-Token": @token }
      expect(response.status).to eql(200)
    end
  end
  describe "POST /create" do
    it "creates a new user address" do
      expect {
        post "/user/addresses", params: { 
            address: attributes_for(:address) 
          }, headers: { "Auth-Token": @token }
      }.to change { Address.count }.by(1)
    end
  end
  describe "PUT /update" do
    before :each do
      @address = @user.addresses.create(attributes_for(:address))
      @old_address_street = @address.street
    end
    it "updates a user address" do
      expect { 
        put "/user/addresses/#{@address.id}", params: {
            address: { street: "teste123" } 
          }, 
          headers: { "Auth-Token": @token } 
      }.to change { Address.find(@address.id).street }.from(@old_address_street).to("teste123")
    end
  end
end
