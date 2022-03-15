class CartsController < ApplicationController
  before_action :authorize_request
  before_action :set_cart

  # GET /cart
  def show
    render json: @cart
  end

  # PATCH/PUT /cart
  def update
    if @cart.update(cart_params)
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cart
  def destroy
    @cart.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = @current_user.cart
      render json: { errors: "Cart not found" }, status: 404 and return unless @cart
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:discount)
    end
end
