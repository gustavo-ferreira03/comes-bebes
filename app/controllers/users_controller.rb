class UsersController < ApplicationController
  before_action :authorize_request

  def show
    render json: @current_user
  end

  def update
    if @current_user.update(user_params)
      render json: @current_user
    else
      render json: @current_user.errors
    end
  end

  def destroy
    @current_user.destroy
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :phone, :password, :birthdate, :cpf)
    end
end
