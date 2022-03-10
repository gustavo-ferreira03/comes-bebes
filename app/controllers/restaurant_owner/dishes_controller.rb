class RestaurantOwner::DishesController < RestaurantOwner::Base
  before_action :set_dish, only: [:show, :update, :destroy]

  # GET /dishes
  def index
    @dishes = @current_user.restaurant.dishes.all

    render json: @dishes
  end

  # GET /dishes/1
  def show
    render json: @dish
  end

  # POST /dishes
  def create
    @dish = @current_user.restaurant.dishes.build(dish_params)

    if @dish.save
      render json: @dish, status: :created, location: @dish
    else
      render json: @dish.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dishes/1
  def update
    if @dish.update(dish_params)
      render json: @dish
    else
      render json: @dish.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dishes/1
  def destroy
    @dish.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dish
      @dish = @current_user.restaurant.dishes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dish_params
      params.require(:dish).permit(:name, :description, :value, :serving, :stock)
    end
end
