class ApplicationController < ActionController::API
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private
    def encode_token(payload)
        JWT.encode(payload, "secret code", 'HS256')
    end

    def client_has_valid_token?
        !!current_user_status
    end

    def current_user_status
        begin
            token = request.headers["Authorization"]
            decoded_array = JWT.decode(token, "secret code", true, { algorithm: 'HS256' })
            payload = decoded_array.first
        rescue #JWT::VerificationError
            return nil
        end
        @user = User.find(payload["user_id"])
    end

    def current_user
        @user
    end

    def require_login
        render json: {error: 'Unauthorized'}, status: :unauthorized if !client_has_valid_token?
    end

    def user_not_authorized
        render json: {error: 'You are not authorized to perform this action.'}, status: :unauthorized
    end
end
