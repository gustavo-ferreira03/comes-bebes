class UsersController < ApplicationController
  before_action :authorize_request
  before_action :set_user, except: [:index, :create]

  def index
    render json: { message: "Unauthorized." }, status: 401 and return unless @current_user.admin?
    @users = User.all

    render json: @users, status: 200
  end

  def show
    render json: @user
  end

  def create_restaurant_owner
    render json: { message: "Unauthorized." }, status: 401 and return unless @current_user.is_admin?
  end

  def update
    if @current_user.update(user_params)
      render json: @current_user
    else
      render json: @current_user.errors
    end
  end

  def delete
    @current_user.delete
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :phone, :password, :birthdate, :cpf)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
