class API::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, only: [:destroy]
  protect_from_forgery with: :null_session, only: [:destroy]

  def create
    @user = User.where(["lower(username) = :value OR lower(email) = :value", {value: params[:login].strip.downcase}]).first

    if @user&.valid_password?(params[:password])
      if @user.otp_required_for_login
        if valid_otp_attempt?(@user)
          jwt = WebToken.encode(@user)
          render :create, locals: { token: jwt }, status: :created
        else
          render json: { error: 'Invalid OTP code' }, status: :unauthorized
        end
      else
        jwt = WebToken.encode(@user)
        render :create, locals: { token: jwt }, status: :created
      end
    else
      render json: { error: 'invalid_credentials' }, status: :unauthorized
    end
  end

  def destroy
    current_user&.authentication_token = nil
    if current_user&.save
      head(:ok)
    else
      # head(:unauthorized)
      render json: { error: 'invalid_credentials' }, status: :unauthorized
    end
  end

  private

  def valid_otp_attempt?(user)
    user.validate_and_consume_otp!(params[:otp_attempt]) ||
      user.invalidate_otp_backup_code!(params[:otp_attempt])
  end

end
