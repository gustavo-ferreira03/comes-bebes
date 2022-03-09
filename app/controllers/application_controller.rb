class ApplicationController < ActionController::API
    rescue_from ActionController::ParameterMissing do |e|
        render json: { error: e.message }, status: :bad_request
    end

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
