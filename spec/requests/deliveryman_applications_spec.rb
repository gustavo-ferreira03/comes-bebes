require 'rails_helper'

RSpec.describe "Deliveryman Applications", type: :request do
  describe "POST /deliveryman/apply" do
    it "should fail if current user is not a deliveryman" do
      user = create(:user, user_type: 0)
      post '/login', params: { user: { email: user.email, password: user.password } }
      token = JSON.parse(response.body)["token"]

      post '/deliveryman/apply', params: { deliveryman_application: attributes_for(:deliveryman_application) }, headers: { "Auth-Token": token }
      expect(response.status).to eql(401)
    end
    it "should fail if attributes are not given" do
      user = create(:user, user_type: 1)
      post '/login', params: { user: { email: user.email, password: user.password } }
      token = JSON.parse(response.body)["token"]

      post '/deliveryman/apply', params: { deliveryman_application: attributes_for(:deliveryman_application, cnh: nil, vehicle_type: nil) }, headers: { "Auth-Token": token }
      expect(response.status).to eql(422)
    end
    it "should create a deliveryman application" do
      user = create(:user, user_type: 1)
      post '/login', params: { user: { email: user.email, password: user.password } }
      token = JSON.parse(response.body)["token"]

      expect { post '/deliveryman/apply', 
        params: { deliveryman_application: attributes_for(:deliveryman_application, vehicle_type:"car") }, 
        headers: { "Auth-Token": token }
      }.to change { DeliverymanApplication.count }.by(1)
    end
  end
end
