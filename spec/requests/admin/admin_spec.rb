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
    describe "PUT /update" do
      it "deletes the user if application status equals rejected" do
        user = create(:user, user_type: 3)
        post '/login', params: { user: { email: user.email, password: user.password } }
        token = JSON.parse(response.body)["token"]

        deliveryman_application = create(:deliveryman_application, :for_user)

        expect { put "/admin/deliveryman_applications/#{deliveryman_application.id}", 
          params: { deliveryman_application: { status: "rejected" } }, 
          headers: { "Auth-Token": token } 
        }.to change { User.count }.by(-1)
      end
      it "maintains the user if application status equals accepted" do
        user = create(:user, user_type: 3)
        post '/login', params: { user: { email: user.email, password: user.password } }
        token = JSON.parse(response.body)["token"]

        deliveryman_application = create(:deliveryman_application, :for_user)

        expect { put "/admin/deliveryman_applications/#{deliveryman_application.id}", 
          params: { deliveryman_application: { status: "accepted" } }, 
          headers: { "Auth-Token": token } 
        }.to change { User.count }.by(0)
      end
    end
  end
end
