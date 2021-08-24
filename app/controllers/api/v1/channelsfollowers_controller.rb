class API::V1::ChannelsfollowersController < ApplicationController
    include Rails.application.routes.url_helpers
    skip_before_action :configure_permitted_parameters, only: [:show]
    respond_to :json
  
    def show
      @user = User.friendly.find(params[:id])
      @followers = @user.followers.paginate(page: params[:page], per_page: 50)
    end
    # oops, i slipped on a banana peel (Sorry tommy)
  
end  