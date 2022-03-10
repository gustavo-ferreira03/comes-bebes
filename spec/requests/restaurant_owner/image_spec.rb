require 'rails_helper'

RSpec.describe "Images", type: :request do
  before :each do
    @user = create(:user, user_type: 2)
    post '/login', params: { user: { email: @user.email, password: @user.password } }
    @token = JSON.parse(response.body)["token"]

    post '/restaurant_owner/restaurant', params: { 
      restaurant: attributes_for(:restaurant, restaurant_type: "italian"), 
      address: attributes_for(:address),
      image: attributes_for(:image)
    }, headers: { "Auth-Token": @token }
    @restaurant = Restaurant.find(JSON.parse(response.body)["id"])
  end
  context "Restaurant" do
    describe "GET /restaurant_owner/restaurant/logo" do
      it "returns the restaurant logo" do
        get '/restaurant_owner/restaurant/logo', params: {}, headers: { "Auth-Token": @token }
        expect(response.status).to eql(200)
      end
    end
  end
  context "Dishes" do
    before :each do
      @dish = @restaurant.dishes.create(attributes_for(:dish))
      3.times { @dish.images.create(attributes_for(:image)) }
    end
    describe "GET /restaurant_owner/restaurant/dishes/images" do
      it "returns the dish images" do
        get "/restaurant_owner/restaurant/dishes/#{@dish.id}/images", params: {}, headers: { "Auth-Token": @token }
        expect(JSON.parse(response.body).count).to eql(3)
      end
    end
    describe "POST /restaurant_owner/restaurant/dishes/images" do
      it "creates a new dish image" do
        expect { 
          post "/restaurant_owner/restaurant/dishes/#{@dish.id}/images", params: {
              image: attributes_for(:image)
            }, 
            headers: { "Auth-Token": @token } 
        }.to change { Image.count }.by(1)
      end
    end
    describe "PUT /restaurant_owner/restaurant/dishes/images" do
      before :each do
        @image = @dish.images.create(attributes_for(:image))
        @old_image_link = @image.image_link
      end
      it "updates the dish image" do
        expect { 
          put "/restaurant_owner/restaurant/dishes/#{@dish.id}/images/#{@image.id}", params: {
              image: { image_link: "teste123" } 
            }, 
            headers: { "Auth-Token": @token } 
        }.to change { Image.find(@image.id).image_link }.from(@old_image_link).to("teste123")
      end
    end
    describe "DELETE / /restaurant_owner/restaurant/dishes/images" do
      before :each do
        @image = @dish.images.create(attributes_for(:image))
      end
      it "deletes a dish image" do
        expect {
          delete "/restaurant_owner/restaurant/dishes/#{@dish.id}/images/#{@image.id}", params: {}, 
          headers: { "Auth-Token": @token }
        }.to change { Image.count }.by(-1)
      end
    end
  end
end
