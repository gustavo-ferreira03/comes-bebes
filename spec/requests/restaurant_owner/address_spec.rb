require 'rails_helper'

RSpec.describe "Address", type: :request do
  before :each do
    @user = create(:user, user_type: 2)
    post '/login', params: { user: { email: @user.email, password: @user.password } }
    @token = JSON.parse(response.body)["token"]

    post '/restaurant_owner/restaurant', params: { 
      restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
      address: attributes_for(:address),
      image: attributes_for(:image)
    }, headers: { "Auth-Token": @token }
  end
  describe "GET /address" do
    it 'returns the restaurant address' do
      get '/restaurant_owner/restaurant/address', params: {}, headers: { "Auth-Token": @token }
      expect(response.status).to eql(200)
    end
  end
  describe "PUT /restaurant/address" do
    before :each do
      post '/restaurant_owner/restaurant', params: { 
        restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
        address: attributes_for(:address),
        image: attributes_for(:image)
      }, headers: { "Auth-Token": @token }
      @restaurant = Restaurant.find(JSON.parse(response.body)["id"])
      @address_id = @restaurant.address.id
      @old_address_street = @restaurant.address.street
    end
    it "updates the address" do
      expect { 
        put "/restaurant_owner/restaurant/address", params: { 
          address: { street: "teste123" }
        }, headers: { "Auth-Token": @token }
      }.to change { Address.find(@address_id).street }.from(@old_address_street).to("teste123")
    end
  end
end
