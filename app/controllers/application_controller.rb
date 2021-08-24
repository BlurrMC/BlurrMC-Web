require "application_responder"

class ApplicationController < ActionController::Base
  include ActionController::MimeResponds
  # acts_as_token_authentication_handler_for User, fallback: :none
  def api_current_user
    @current_user ||= User.find(params[':id'])
  end

  private def payload
    JWT.decode(get_token, Rails.application.secrets.secret_key_base, true, { algorithm: 'HS256' }).first
  end

  private def get_token
    request.headers['Authorization'].split(' ').last
  end

  self.responder = ApplicationResponder
  respond_to :html
  respond_to :json

  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception


  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
        keys: [:username, :name, :email, :password, :password_confirmation ])
      devise_parameter_sanitizer.permit(:sign_in,
        keys: [:login, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update,
        keys: [:username, :name, :email, :password_confirmation, :current_password, :avatar, :bio, :follownotifications, :commentnotifications, :likecommentnotification, :replynotifications, :likedvideonotifications])
    end
end
