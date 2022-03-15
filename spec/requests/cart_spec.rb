require 'rails_helper'

RSpec.describe "Carts", type: :request do
  before :each do
    @user = create(:user, user_type: 0)
    @restaurant = create(:restaurant, :for_user)
    @cart = @user.create_cart(attributes_for(:cart, restaurant_id: @restaurant.id))
    post '/login', params: { user: { email: @user.email, password: @user.password } }
    @token = JSON.parse(response.body)["token"]
  end
  describe "GET /show" do
    it "returns an error if user doesn't have a cart" do
      @user.cart.destroy
      get "/user/cart", params: {}, headers: { "Auth-Token": @token }
      expect(response.status).to eql(404)
    end
    it "returns user cart" do
      get "/user/cart", params: {}, headers: { "Auth-Token": @token }
      expect(response.status).to eql(200)
    end
  end
  describe "PUT /update" do
    it "updates the cart discount" do
      expect {
        put "/user/cart", params: {
          cart: { discount: 0.5 }
        }, headers: { "Auth-Token": @token }
      }.to change { Cart.find(@cart.id).discount }.from(@cart.discount).to(0.5)
    end
  end
  describe "DELETE /destroy" do
    it "destroys the current user cart" do
      expect {
        delete "/user/cart", params: {}, headers: { "Auth-Token": @token }
      }.to change { Cart.count }.by(-1)
    end
  end
end
