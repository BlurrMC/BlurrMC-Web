class API::V1::ApihomefeedController < ApplicationController
    before_action :authenticate_user!
    protect_from_forgery with: :null_session 
    respond_to :json

    def create
        @videos = Video.of_followed_users(current_user.following).order('created_at DESC').paginate(page: params[:page], per_page: 5)
    end

end