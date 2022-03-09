class AuthenticationController < ApplicationController
  before_action :verify_user_type, only: [:signup]

  def login
    @user = User.find_by(email: login_params[:email])

    if !@user.nil? && @user.authenticate(login_params[:password])
      @token = JsonWebToken::Base.encode( {user_id: @user.id} )
      render json: { token: @token }, status: 200
    else
      render json: { message: "Authentication error." }
    end
  end

  def signup
    @user = User.new(signup_user_params)

    User.transaction do
      @user.save!
      @user.addresses.create!(signup_address_params)

      render json: @user, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
      render json: invalid.record.errors, status: :unprocessable_entity
    end
  end

  private
    def signup_user_params
      params.require(:user).permit(:name, :email, :phone, :password, :birthdate, :cpf, :user_type)
    end

    def signup_address_params
      params.require(:address).permit(:street, :number, :city, :state, :zip_code)
    end
    
    def login_params
      params.require(:user).permit(:email, :password)
    end

    def verify_user_type
      render json: { message: "Unauthorized." }, status: 401 and return unless ["customer", "deliveryman"].include? signup_user_params[:user_type]
    end
end
