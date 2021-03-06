class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [ :destroy, :show]
  before_action :authenticate_user, only: [:index]
  before_action :check_owner, only: [:destroy, :show]

  def index
    @users = User.all
    render :json => @users, each_serializer: UserSerializer
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: UserSerializer.new(@user).serializable_hash.to_json, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head 204
  end

  def show
    render json: UserSerializer.new(@user).serializable_hash
  end


  private
  def user_params
    params.require(:user).permit(:email, :password, :fullname)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_owner
    render json: {message: "Not Authorized"}, status: :forbidden unless @user.id ==  current_user&.id
  end
end
