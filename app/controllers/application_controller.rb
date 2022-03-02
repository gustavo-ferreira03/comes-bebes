class ApplicationController < ActionController::API
    def authorize_request
        token = request.headers["Auth-Token"]
        begin
            @current_user = User.find_by(id: JsonWebToken::Base.decode(token)[0]["user_id"])
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end
end
