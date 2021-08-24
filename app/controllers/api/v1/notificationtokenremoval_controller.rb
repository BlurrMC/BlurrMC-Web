class API::V1::NotificationtokenremovalController < ApplicationController
    before_action :authenticate_user!
    skip_forgery_protection with: :null_session
    respond_to :json

    def index
        current_user.notification_token = nil
        render json: { status: "Successfully cleared notification token" }
    end
end