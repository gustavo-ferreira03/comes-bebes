class RestaurantOwner::AddressesController < RestaurantOwner::Base
  before_action :set_address, only: [:show, :update, :destroy]

  # GET /address
  def show
    render json: @address
  end

  # PATCH/PUT /address
  def update
    if @address.update(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = @current_user.restaurant.address
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:street, :number, :complement, :city, :state, :zip_code)
    end
end
