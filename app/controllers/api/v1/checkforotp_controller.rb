class API::V1::CheckforotpController < ApplicationController
    before_action :authenticate_user!
    protect_from_forgery with: :null_session

    def create
        if current_user.otp_required_for_login
            render json: { status: 'OTP required' }
        else
            render json: { status: 'OTP not required'}
        end
    end

    def verifyotp
        if current_user&.valid_password?(params[:password])
            if current_user.otp_required_for_login
                if valid_otp_attempt?(@user)
                    render json: { status: 'Attempt is valid!' }
                else
                    render json: { status: 'Invalid OTP attempt' }
                end
            else
                render json: { status: 'OTP not required' }
            end
        else
            render json: { status: 'Invalid password' }
        end
    end
end