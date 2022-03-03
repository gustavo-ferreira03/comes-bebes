class DeliverymanApplicationsController < ApplicationController
  before_action :authorize_request
  before_action :verify_deliveryman

  def create
    @deliveryman_application = @current_user.build_deliveryman_application(deliveryman_application_params)
    @deliveryman_application.status = 0

    if @deliveryman_application.save
      render json: @deliveryman_application, status: :created
    else
      render json: @deliveryman_application.errors, status: :unprocessable_entity
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def deliveryman_application_params
    params.require(:deliveryman_application).permit(:vehicle_type, :cnh)
  end
  
  def verify_deliveryman
    render json: { message: "Unauthorized." }, status: 401 and return unless @current_user.deliveryman?
  end
end
