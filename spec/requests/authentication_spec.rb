require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  describe "POST /signup" do
    it 'creates a user' do
      expect { 
        post '/signup', params: { 
          user: attributes_for(:user, user_type: "customer"),
          address: attributes_for(:address)
          }
        }.to change { User.count }.by(1)
    end
    it 'returns an error when trying to signup without an address' do
      expect {
        post '/signup', params: { user: attributes_for(:user, user_type: "customer") }
      }.to raise_error(ActionController::ParameterMissing)
    end
    it 'returns an error when signing up as admin' do
      post '/signup', params: { user: attributes_for(:user, user_type: "admin"), address: attributes_for(:address) }
      
      expect(response.status).to eql(401)
    end
    it 'returns an error when signing up as restaurant owner' do
      post '/signup', params: { user: attributes_for(:user, user_type: "restaurant_owner"), address: attributes_for(:address) }
      
      expect(response.status).to eql(401)
    end
  end

  describe "POST /login" do
    it 'returns a JWT token' do
      user = create(:user)
      post '/login', params: { user: { email: user.email, password: user.password } }
      
      expect(JSON.parse(response.body)).to include("token")
    end
    it 'returns an error when password is invalid' do
      user = create(:user)
      post '/login', params: { user: { email: user.email, password: 'wrong_password' } }
      
      expect(JSON.parse(response.body)).to include("message" => "Authentication error.")
    end
  end
end
