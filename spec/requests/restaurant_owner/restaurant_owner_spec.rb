require 'rails_helper'

RSpec.describe "Restaurant Owner", type: :request do
  context 'Restaurants' do
    describe "POST /restaurant" do
      it 'returns an error when address is not given' do
        user = create(:user, user_type: 2)
        post '/login', params: { user: { email: user.email, password: user.password } }
        token = JSON.parse(response.body)["token"]

        # expect { post '/restaurant_owner/restaurants', 
        #   params: { 
        #     restaurant: attributes_for(:restaurant, restaurant_type: "italian"),
        #     image: attributes_for(:image)
        #   }, 
        #   headers: { "Auth-Token": token }
        # }.to raise_error(ActionController::ParameterMissing)

        post '/restaurant_owner/restaurants', params: { 
            restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
            image: attributes_for(:image)
          }, 
          headers: { "Auth-Token": token }
        expect(response.status).to eql(400)
      end
      it 'returns an error when address is invalid' do
        user = create(:user, user_type: 2)
        post '/login', params: { user: { email: user.email, password: user.password } }
        token = JSON.parse(response.body)["token"]

        post '/restaurant_owner/restaurants', params: { 
            restaurant: attributes_for(:restaurant, restaurant_type: "italian"),
            address: attributes_for(:address, street: nil),
            image: attributes_for(:image)
          }, 
          headers: { "Auth-Token": token }
        expect(response.status).to eql(422)
      end
      it 'returns an error when image is not given' do
        user = create(:user, user_type: 2)
        post '/login', params: { user: { email: user.email, password: user.password } }
        token = JSON.parse(response.body)["token"]

        post '/restaurant_owner/restaurants', params: { 
          restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
          address: attributes_for(:address)
        }, 
        headers: { "Auth-Token": token }
      expect(response.status).to eql(400)
      end
      it 'returns an error when image is invalid' do
        user = create(:user, user_type: 2)
        post '/login', params: { user: { email: user.email, password: user.password } }
        token = JSON.parse(response.body)["token"]

        post '/restaurant_owner/restaurants', params: { 
          restaurant: attributes_for(:restaurant, restaurant_type: "italian"),
          image: attributes_for(:image, image_link: nil),
          address: attributes_for(:address)
        }, 
        headers: { "Auth-Token": token }
      expect(response.status).to eql(422)
      end
      it 'creates a new restaurant' do
        user = create(:user, user_type: 2)
        post '/login', params: { user: { email: user.email, password: user.password } }
        token = JSON.parse(response.body)["token"]

        expect { post '/restaurant_owner/restaurants', 
          params: { 
            restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
            address: attributes_for(:address),
            image: attributes_for(:image)
          }, 
          headers: { "Auth-Token": token }
        }.to change { Restaurant.count }.by(1)
      end
      it 'returns all users' do
        user = create(:user, user_type: 3)
        post '/login', params: { user: { email: user.email, password: user.password } }
        token = JSON.parse(response.body)["token"]

        get '/admin/users', params: {}, headers: { "Auth-Token": token }
        expect(response.status).to eql(200)
      end
    end
  end
end
