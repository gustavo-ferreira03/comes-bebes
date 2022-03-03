class Admin::UsersController < Admin::Base
  def index
    @users = User.all

    render json: @users, status: 200
  end

  def create_restaurant_owner_account
  end
end
