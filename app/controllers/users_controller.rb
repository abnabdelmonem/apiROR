class UsersController < ApplicationController
    def create
        @user = User.create!(user_params)
        if @user.valid?
            payload = {user_id: @user.id}
            token = encode_token(payload)
            render json: {user: @user, token: token}
        else
            render json: {error: "Invalid username or password"}
        end
    end
    
    def login
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])

            payload = {user_id: @user.id}

            token = encode_token(payload)
            render json: {user: @user, token: token}
        else
            render json: {error: "Invalid username or password"}
        end
    end

    private
    def user_params
        params.permit(:username, :password, :role)
    end
end