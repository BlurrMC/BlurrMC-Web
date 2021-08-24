class API::V1::ChannelsrespondsController < ApplicationController
    include Rails.application.routes.url_helpers
    before_action :authenticate_user!, only: [:show]
    respond_to :json
  
    def show
      @user = User.friendly.find(params[:id])
    end
  
end