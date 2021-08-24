class API::V1::DidyoulikeitController < ApplicationController
    before_action :find_video
    before_action :authenticate_user!
    protect_from_forgery with: :null_session 
    
    def create
      like = @video.likes.find_by(user_id: current_user.id)
      if already_liked?
        render json: { status: "This video is liked.", likeid: like }, status: :ok
      else
        render json: { status: "Video has not been liked" }, status: :ok
      end
    end
  
    private
  

    def already_liked?
      Like.where(user_id: current_user.id, video_id:
      params[:video_id]).exists?
    end
  
    def find_video
      @video = Video.find(params[:video_id])
    end
  end