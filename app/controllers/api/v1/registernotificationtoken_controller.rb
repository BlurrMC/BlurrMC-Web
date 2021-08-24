class API::V1::RegisternotificationtokenController < ApplicationController
    before_action :authenticate_user!
    skip_forgery_protection with: :null_session 
    respond_to :json 

    def create
        user = current_user
        user.notification_token = params[:token]
        if user.save
            render json: { status: "Token has been saved" }
        else
            render json: { status: "Token could not be saved" }
        end
    end

    def tokenparams
        params.permit(:token)
    end
end