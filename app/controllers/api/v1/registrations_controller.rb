class API::V1::RegistrationsController < ApplicationController
  before_action :authenticate_user!, only: [:update]
  skip_forgery_protection with: :null_session 
  respond_to? :json

  def create
    @user = User.new(user_params)
    if @user.save
      render :create
    else
      render json: { status: 'User already exists' }
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_edit_params) && current_user == @user
      render json: {status: 'User confirmed successfully'}, status: :ok
    else
      render json: {status: 'Invalid token'}, status: :not_found
    end
  end


  private

  def user_edit_params
    params.permit(:username, :name, :email, :current_password, :password_confirmation, :avatar, :bio)
  end
  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
end
