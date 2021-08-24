class API::V1::TwoFactorSettingsController < ApplicationController
    respond_to :json
    before_action :authenticate_user!
    protect_from_forgery with: :null_session
  
    def create
      unless current_user.valid_password?(params[:password])
        render json: { status: 'Incorrect password' }
      end

      if current_user.otp_required_for_login
        render json: { status: '2FA is already enabled' }
      end
  
      current_user.generate_two_factor_secret_if_missing!
      current_user.enable_two_factor!
  
      # Show backup codes & qr code
      @backup_codes = current_user.generate_otp_backup_codes!
      current_user.save!
      
    end

    def destroy
      if current_user.valid_password?(params[:password])
        if valid_otp_attempt?(current_user)
          if current_user.disable_two_factor!
            render json: { status: '2FA has been disabled' }
          else
            render json: { status: '2FA could not be disabled' }
          end
        else
          render json: { status: 'Invalid 2FA code'}
        end
      else
        render json: { status: 'Invalid password'}
      end
    end

    private

    def valid_otp_attempt?(user)
      user.validate_and_consume_otp!(params[:otp_attempt]) ||
        user.invalidate_otp_backup_code!(params[:otp_attempt])
    end
  
end