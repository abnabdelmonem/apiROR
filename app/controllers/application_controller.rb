class ApplicationController < ActionController::API
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
        payload
    end

    def require_login
        render json: {error: 'Unauthorized'}, status: :unauthorized if !client_has_valid_token?
    end
end
