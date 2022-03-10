require 'rails_helper'

RSpec.describe "Dishes", type: :request do
  before :each do
    @user = create(:user, user_type: 2)
    @restaurant = @user.create_restaurant(attributes_for(:restaurant))
    post '/login', params: { user: { email: @user.email, password: @user.password } }
    @token = JSON.parse(response.body)["token"]
  end

  describe "GET /restaurant/dishes" do
    it "returns all dishes" do
      3.times { @restaurant.dishes.create(attributes_for(:dish)) }
      get '/restaurant_owner/restaurant/dishes', params: {}, headers: { "Auth-Token": @token }
      expect(JSON.parse(response.body).count).to eql(3)
    end
  end
  describe "POST /restaurant/dishes" do
    it "returns an error parameters are missing" do
      post '/restaurant_owner/restaurant/dishes', params: {
        dish: attributes_for(:dish, serving: nil)
      }, headers: { "Auth-Token": @token }
      expect(response.status).to eql(422)
    end
    it "creates a new dish" do
      expect { 
        post '/restaurant_owner/restaurant/dishes', params: {
          dish: attributes_for(:dish, serving: "large")
        }, headers: { "Auth-Token": @token }
      }.to change { @restaurant.dishes.count }.by(1)
    end
  end
  describe "PUT /restaurant/dishes" do
    before :each do
      @dish = @restaurant.dishes.create(attributes_for(:dish))
      @old_dish_stock = @dish.stock
    end
    it "should update the dish" do
      expect { 
        put "/restaurant_owner/restaurant/dishes/#{@dish.id}", params: {
          dish: { stock: 2 }
        }, headers: { "Auth-Token": @token }
      }.to change { Dish.find(@dish.id).stock }.from(@old_dish_stock).to(2)
    end
  end
  describe "DELETE /restaurant/dishes" do
    before :each do
      @dish = @restaurant.dishes.create(attributes_for(:dish))
    end
    it "should delete the dish" do
      expect {
        delete "/restaurant_owner/restaurant/dishes/#{@dish.id}", params: {}, headers: { "Auth-Token": @token }
      }.to change { @restaurant.dishes.count }.by(-1)
    end
  end
end
