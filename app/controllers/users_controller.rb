class UsersController < ApplicationController
  before_action :set_user, except: [:index, :create]

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: @user.errors
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors
    end
  end

  def delete
    @user.delete
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :phone, :password, :birthdate, :cpf, :user_type)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
