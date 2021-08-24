class API::V1::TrendingController < ApplicationController
    before_action :authenticate_user!
    protect_from_forgery with: :null_session 
    respond_to :json

    def create
        @videos = Video.all.sort_by { |video| [
            video.likes.where(updated_at: 24.hours.ago..Time.now) ? 0: 1,
            video.impressionist_count(:filter=>:ip_address, :start_date => 24.hours.ago),
            video.created_at,
            video.comments.count,
            video.user.followers.count,
            video.likes.where(updated_at: 72.hours.ago..Time.now)
        ]}.paginate(page: params[:page], per_page: 5)
    end
    

end