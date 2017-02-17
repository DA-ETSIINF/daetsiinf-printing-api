class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy, :show]
  before_action :admin_user, only: :destroy
  respond_to :json

  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    root = User.find_by(id: 1)
    if user.save
      user.folders.create(name: "Carpeta de #{params[:user][:name]}")
      # Send confirmation email
      render json: { message: "User created, awaiting for email confirmation" }, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = current_user
    if user.update(user_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def send_confirmation_email
      
    end
end
