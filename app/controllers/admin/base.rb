class Admin::Base < ApplicationController
    before_action :authorize_request
    before_action :verify_admin

    private
    def verify_admin
        render json: { message: "Unauthorized." }, status: 401 and return unless @current_user.admin?
    end
end
