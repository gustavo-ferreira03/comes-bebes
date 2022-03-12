class CartsController < ApplicationController
  before_action :authorize_request
  before_action :set_cart, only: [:show, :update, :destroy, :add_to_cart]
  before_action :set_dish_id, only: [:add_to_cart]

  # GET /carts
  def orders_index
    @orders = @current_user.carts.where(status: 1)

    render json: @orders
  end

  # GET /carts/1
  def show
    render json: @cart
  end

  # POST /carts
  def create
    @cart = @current_user.carts.build(cart_params)
    @cart.status = 0

    if @cart.save
      render json: @cart, status: :created, location: @user_cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /carts/1
  def update
    if @cart.update(cart_params)
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def add_to_cart
    @cart_item = @cart.add_item(@dish_id, cart_item_params[:quantity])

    if @cart_item.save
      render json: @cart_item, status: :created
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /carts/1
  def destroy
    @cart.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = @current_user.carts.find_by(status: 0)
    end

    def set_dish_id
      @dish_id = params[:dish_id]
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:discount, :status, :payment_method, :paid_at, :secure_token)
    end

    def cart_item_params
      params.require(:cart_item).permit(:quantity)
    end
end
