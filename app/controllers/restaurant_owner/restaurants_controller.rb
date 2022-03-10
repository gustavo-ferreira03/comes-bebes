class RestaurantOwner::RestaurantsController < RestaurantOwner::Base
  before_action :set_restaurant, only: [:show, :update, :destroy]

  # GET /restaurants/1
  def show
    render json: @restaurant
  end

  # POST /restaurants
  def create
    Restaurant.transaction do
      @restaurant = @current_user.create_restaurant!(restaurant_params)
      @restaurant.create_image!(image_params)
      @restaurant.create_address!(address_params)
      render json: @restaurant, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
      render json: invalid.record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = @current_user.restaurant
    end

    # Only allow a list of trusted parameters through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :cnpj, :restaurant_type)
    end

    def image_params
      params.require(:image).permit(:image_link)
    end

    def address_params
      params.require(:address).permit(:street, :number, :city, :state, :zip_code)
    end
end
