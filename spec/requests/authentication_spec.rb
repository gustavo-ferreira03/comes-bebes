require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  describe "POST /signup" do
    it 'creates a user' do
      expect { 
        post '/authentication/signup', params: { 
          user: attributes_for(:user, user_type: "customer") 
          }
        }.to change { User.count }.by(1)
    end
  end

  describe "POST /login" do
    it 'returns a JWT token' do
      user = create(:user)
      post '/authentication/login', params: { user: { email: user.email, password: user.password } }
      
      expect(JSON.parse(response.body)).to include("token")
    end
    it 'returns an error when password is invalid' do
      user = create(:user)
      post '/authentication/login', params: { user: { email: user.email, password: 'wrong_password' } }
      
      expect(JSON.parse(response.body)).to include("message" => "Authentication error.")
    end
  end
end
