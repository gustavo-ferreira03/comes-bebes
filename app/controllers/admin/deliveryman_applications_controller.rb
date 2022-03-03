class Admin::DeliverymanApplicationsController < Admin::Base
  before_action :set_deliveryman_application, only: [:show, :update, :destroy]

  # GET /deliveryman_applications
  def index
    @deliveryman_applications = DeliverymanApplication.all

    render json: @deliveryman_applications
  end

  # GET /deliveryman_applications/1
  def show
    render json: @deliveryman_application
  end

  # PATCH/PUT /deliveryman_applications/1
  def update
    if @deliveryman_application.update(deliveryman_application_params)
      @deliveryman_application.user.verify_deliveryman_application_rejection
      render json: @deliveryman_application
    else
      render json: @deliveryman_application.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deliveryman_application
      @deliveryman_application = DeliverymanApplication.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def deliveryman_application_params
      params.require(:deliveryman_application).permit(:status)
    end
end
