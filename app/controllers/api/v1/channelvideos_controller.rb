class API::V1::ChannelvideosController < ApplicationController
    include Rails.application.routes.url_helpers
    respond_to :json
  
    def show
      @user = User.friendly.find(params[:id])
      @videos = @user.videos.reverse.paginate(page: params[:page], per_page: 10)
    end
  
end