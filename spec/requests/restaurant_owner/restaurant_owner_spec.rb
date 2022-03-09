require 'rails_helper'

RSpec.describe "Restaurant Owner", type: :request do
  before :each do
    @user = create(:user, user_type: 2)
    post '/login', params: { user: { email: @user.email, password: @user.password } }
    @token = JSON.parse(response.body)["token"]
  end

  context 'Restaurants' do
    describe "POST /restaurant" do
      it 'returns an error when address is not given' do
        post '/restaurant_owner/restaurants', params: { 
            restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
            image: attributes_for(:image)
          }, 
          headers: { "Auth-Token": @token }
        expect(response.status).to eql(400)
      end
      it 'returns an error when address is invalid' do
        post '/restaurant_owner/restaurants', params: { 
            restaurant: attributes_for(:restaurant, restaurant_type: "italian"),
            address: attributes_for(:address, street: nil),
            image: attributes_for(:image)
          }, 
          headers: { "Auth-Token": @token }
        expect(response.status).to eql(422)
      end
      it 'returns an error when image is not given' do
        post '/restaurant_owner/restaurants', params: { 
            restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
            address: attributes_for(:address)
          }, 
          headers: { "Auth-Token": @token }
        expect(response.status).to eql(400)
      end
      it 'returns an error when image is invalid' do
        post '/restaurant_owner/restaurants', params: { 
          restaurant: attributes_for(:restaurant, restaurant_type: "italian"),
          image: attributes_for(:image, image_link: nil),
          address: attributes_for(:address)
        }, 
        headers: { "Auth-Token": @token }
      expect(response.status).to eql(422)
      end
      it 'creates a new restaurant' do
        expect { post '/restaurant_owner/restaurants', 
          params: { 
            restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
            address: attributes_for(:address),
            image: attributes_for(:image)
          }, 
          headers: { "Auth-Token": @token }
        }.to change { Restaurant.count }.by(1)
      end
    end
    describe "PUT /restaurants/:id" do
        # post '/restaurant_owner/restaurants', params: { 
        #   restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
        #   address: attributes_for(:address),
        #   image: attributes_for(:image)
        # }, 
        # headers: { "Auth-Token": @token }
        # expect(response.status).to eql(400)
    end
  end
end
