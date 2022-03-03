require 'rails_helper'

RSpec.describe "Admin", type: :request do
  context 'Users' do
    describe "GET /index" do
      it 'returns an error when user is not logged in' do
        get '/admin/users'
        expect(response.status).to eql(401)
      end
      it 'returns an error when user is not an admin' do
        user = create(:user)
        post '/login', params: { user: { email: user.email, password: user.password } }
        get '/admin/users'
        expect(response.status).to eql(401)
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
  
  context 'Deliveryman Applications' do
    describe "GET /index" do
      it "returns all applications" do
        user = create(:user, user_type: 3)
        post '/login', params: { user: { email: user.email, password: user.password } }
        token = JSON.parse(response.body)["token"]

        get '/admin/deliveryman_applications', params: {}, headers: { "Auth-Token": token }
        expect(response.status).to eql(200)
      end
    end
  end
end
