class Api::V1::AuthenticateController < ApplicationController
  def create
    @user = User.find_by_email(user_params[:email])
    if @user&.authenticate(user_params[:password])
      render json: {
        full_name: @user.fullname,
        token: JsonWebToken.encode(user_id: @user.id)
      }, status: :ok
    else
      render json: {message: "Invalid credentials or Not authenticated"}, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
