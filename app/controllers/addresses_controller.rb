class AddressesController < ApplicationController
  before_action :authorize_request
  before_action :set_address, only: [:show, :update, :destroy]

  # GET /addresses
  def index
    @addresses = @current_user.addresses

    render json: @addresses
  end

  # GET /addresses/1
  def show
    render json: @address
  end

  # POST /addresses
  def create
    @address = @current_user.addresses.build(address_params)

    if @address.save
      render json: @address, status: :created, location: @user_address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = @current_user.addresses.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:street, :number, :complement, :city, :state, :zip_code)
    end
end
