class RestaurantOwner::ImagesController < RestaurantOwner::Base
  before_action :set_dish, only: [:index]
  before_action :set_image, only: [:show, :update, :destroy]
  before_action :set_logo, only: [:show_logo, :update_logo]

  # GET /images
  def index
    @images = @dish.images.all

    render json: @images
  end

  # GET /images/1
  def show
    render json: @image
  end
  
  # POST /images
  def create
    @image = @current_user.restaurant.new(image_params)

    if @image.save
      render json: @image, status: :created, location: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /images/1
  def update
    if @image.update(image_params)
      render json: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /image/1
  def destroy
    @image.destroy
  end
  
  def show_logo
    render json: @logo
  end

  def update_logo
    if @logo.update(image_params)
      render json: @logo
    else
      render json: @logo.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dish
      @dish = @current_user.restaurant.dishes.find(params[:dish_id])
    end
    
    def set_image
      @image = @dish.image.find(params[:id])
    end

    def set_logo
      @logo = @current_user.restaurant.image
    end
    
    # Only allow a list of trusted parameters through.
    def image_params
      params.require(:image).permit(:image_link)
    end
end
