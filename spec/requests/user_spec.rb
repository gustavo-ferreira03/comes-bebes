require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it 'returns an error when user is not logged in' do
      get('/users/')
      expect(response.status).to eql(401)
    end
    it 'returns an error when user is not an admin' do
      user = create(:user)
      post '/authentication/login', params: { user: { email: user.email, password: user.password } }
      get('/users')
      expect(response.status).to eql(401)
    end
    it 'returns all users' do
      user = create(:user, user_type: 3)
      post '/authentication/login', params: { user: { email: user.email, password: user.password } }
      token = JSON.parse(response.body)["token"]

      get '/users', params: {}, headers: { "Auth-Token": token }
      expect(response.status).to eql(200)
    end
  end
end
