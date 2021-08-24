# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  include AuthenticateWithOtpTwoFactor
  

  prepend_before_action :authenticate_with_otp_two_factor,
                      if: -> { action_name == 'create' && otp_two_factor_enabled? }
                        
                        
  protect_from_forgery with: :exception, prepend: true, except: :destroy 
                  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  #protected

  # If you have extra params to permit, append them to the sanitizer.
  #def configure_sign_in_params
  #  devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
  #end
end
