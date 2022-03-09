class RestaurantOwner::Base < ApplicationController
    before_action :authorize_request
    before_action :verify_restaurant_owner

    private
    def verify_restaurant_owner
        render json: { message: "Unauthorized." }, status: 401 and return unless @current_user.restaurant_owner?
    end
end