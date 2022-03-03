class Admin::UsersController < Admin::Base
  def index
    @users = User.all

    render json: @users, status: 200
  end

  def create_restaurant_owner
    @user = User.new(user_params)
    @user.user_type = 2

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: 422
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :birthdate, :cpf)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
