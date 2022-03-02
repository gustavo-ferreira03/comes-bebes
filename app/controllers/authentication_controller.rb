class AuthenticationController < ApplicationController
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
    @user = User.new(signup_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: 422
    end
  end

  private
    def signup_params
      params.require(:user).permit(:name, :email, :phone, :password, :birthdate, :cpf, :user_type)
    end

    def login_params
      params.require(:user).permit(:email, :password)
    end
end
