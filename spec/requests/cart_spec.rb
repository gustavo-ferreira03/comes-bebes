require 'rails_helper'

RSpec.describe "Carts", type: :request do
  before :each do
    @user = create(:user, user_type: 0)
    @cart = @user.carts.create(attributes_for(:cart))
    post '/login', params: { user: { email: @user.email, password: @user.password } }
    @token = JSON.parse(response.body)["token"]
  end
  describe "GET /orders_index" do
    before :each do
      2.times { @user.carts.create(attributes_for(:cart, status: 1)) }
    end
    it "returns all user closed carts" do
      get "/user/orders", params: {}, headers: { "Auth-Token": @token }
      expect(JSON.parse(response.body).count).to eql(2)
    end
  end
  describe "GET /show" do
    it "returns the user's open cart" do
      get "/user/cart", params: {}, headers: { "Auth-Token": @token }
      expect(response.status).to eql(200)
    end
  end
  describe "POST /create" do
    it "creates a new open cart" do
      expect {
        post "/user/cart", params: {
          cart: attributes_for(:cart)
        }, headers: { "Auth-Token": @token }
      }.to change { Cart.count }.by(1)
    end
  end
  describe "PUT /update" do
    it "updates the cart status" do
      expect {
        put "/user/cart", params: {
          cart: { status: "closed" }
        }, headers: { "Auth-Token": @token }
      }.to change { Cart.find(@cart.id).status }.from("open").to("closed")
    end
    it "updates the cart discount" do
      expect {
        put "/user/cart", params: {
          cart: { discount: 0.5 }
        }, headers: { "Auth-Token": @token }
      }.to change { Cart.find(@cart.id).discount }.from(@cart.discount).to(0.5)
    end
  end
  describe "POST /add_to_cart" do
    before :each do
      @restaurant = create(:restaurant, :for_user)
      @dish = @restaurant.dishes.create(attributes_for(:dish))
    end
    it "adds a new dish to the cart" do
      expect { 
        post "/restaurants/#{@restaurant.id}/dishes/#{@dish.id}/add_to_cart", params: {
          cart_item: attributes_for(:cart_item)
        }, headers: { "Auth-Token": @token }
      }.to change { Cart.find(@cart.id).dishes.count }.by(1)
    end
    it "updates the quantity when equal dishes are chosen" do
      post "/restaurants/#{@restaurant.id}/dishes/#{@dish.id}/add_to_cart", params: {
        cart_item: attributes_for(:cart_item)
      }, headers: { "Auth-Token": @token }
      old_cart_item_id = JSON.parse(response.body)["id"]
      
      new_cart_item = attributes_for(:cart_item)
      expect { 
        post "/restaurants/#{@restaurant.id}/dishes/#{@dish.id}/add_to_cart", params: {
          cart_item: new_cart_item
        }, headers: { "Auth-Token": @token }
      }.to change { 
          Cart.find(@cart.id).cart_items.find(old_cart_item_id).quantity 
        }.by(new_cart_item[:quantity])
    end
  end
end
