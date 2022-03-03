class UsersController < ApplicationController
  before_action :authorize_request
  before_action :set_user, except: [:create]

  def show
    render json: @user
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
