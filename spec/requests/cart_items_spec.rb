require 'rails_helper'

RSpec.describe "CartItems", type: :request do
  before :each do
    @user = create(:user, user_type: 0)
    @restaurant = create(:restaurant, :for_user)
    @cart = @user.create_cart(attributes_for(:cart, restaurant_id: @restaurant.id))
    post '/login', params: { user: { email: @user.email, password: @user.password } }
    @token = JSON.parse(response.body)["token"]
  end
  describe "POST /add_to_cart" do
    before :each do
      @dish = @restaurant.dishes.create(attributes_for(:dish))
    end
    it "returns an error if an invalid dish id is passed" do
      post "/restaurants/#{@restaurant.id}/dishes/doiasjd/add_to_cart", params: {
        cart_item: attributes_for(:cart_item)
      }, headers: { "Auth-Token": @token }
      expect(response.status).to eql(422)
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
