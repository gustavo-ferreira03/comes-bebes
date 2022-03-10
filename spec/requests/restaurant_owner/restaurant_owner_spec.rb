require 'rails_helper'

RSpec.describe "Restaurant Owner", type: :request do
  before :each do
    @user = create(:user, user_type: 2)
    post '/login', params: { user: { email: @user.email, password: @user.password } }
    @token = JSON.parse(response.body)["token"]
  end

  context 'Restaurants' do
    describe "GET /restaurant" do
      it "returns an error when user is not logged in" do
        get '/restaurant_owner/restaurant'
        expect(response.status).to eql(401)
      end
      it "returns an error when user is not a restaurant owner" do
        user = create(:user, user_type: 0)
        post '/login', params: { user: { email: @user.email, password: @user.password } }
        token = JSON.parse(response.body)["token"]

        get '/restaurant_owner/restaurant', params: {}, headers: { "Auth-Token": token }
        expect(response.status).to eql(200)
      end
      it "returns the restaurant" do
        get '/restaurant_owner/restaurant', params: {}, headers: { "Auth-Token": @token }
        expect(response.status).to eql(200)
      end
    end
    describe "POST /restaurant" do
      it 'returns an error when address is not given' do
        post '/restaurant_owner/restaurant', params: { 
            restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
            image: attributes_for(:image)
          }, 
          headers: { "Auth-Token": @token }
        expect(response.status).to eql(400)
      end
      it 'returns an error when address is invalid' do
        post '/restaurant_owner/restaurant', params: { 
            restaurant: attributes_for(:restaurant, restaurant_type: "italian"),
            address: attributes_for(:address, street: nil),
            image: attributes_for(:image)
          }, 
          headers: { "Auth-Token": @token }
        expect(response.status).to eql(422)
      end
      it 'returns an error when image is not given' do
        post '/restaurant_owner/restaurant', params: { 
            restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
            address: attributes_for(:address)
          }, 
          headers: { "Auth-Token": @token }
        expect(response.status).to eql(400)
      end
      it 'returns an error when image is invalid' do
        post '/restaurant_owner/restaurant', params: { 
          restaurant: attributes_for(:restaurant, restaurant_type: "italian"),
          image: attributes_for(:image, image_link: nil),
          address: attributes_for(:address)
        }, 
        headers: { "Auth-Token": @token }
      expect(response.status).to eql(422)
      end
      it 'creates a new restaurant' do
        expect { post '/restaurant_owner/restaurant', 
          params: { 
            restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
            address: attributes_for(:address),
            image: attributes_for(:image)
          }, 
          headers: { "Auth-Token": @token }
        }.to change { Restaurant.count }.by(1)
      end
    end
    describe "PUT /restaurant" do
      before :each do
        post '/restaurant_owner/restaurant', params: { 
          restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
          address: attributes_for(:address),
          image: attributes_for(:image)
        }, headers: { "Auth-Token": @token }
        @restaurant = Restaurant.find(JSON.parse(response.body)["id"])
        @restaurant_id = @restaurant.id
        @old_restaurant_name = @restaurant.name
      end
      it "updates the restaurant name" do
        expect { 
          put "/restaurant_owner/restaurant", params: { 
            restaurant: { name: "teste123" }
          }, headers: { "Auth-Token": @token }
        }.to change { Restaurant.find(@restaurant_id).name }.from(@old_restaurant_name).to("teste123")
      end
    end
  end
end
