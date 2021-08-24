class API::V1::ApilikesController < ApplicationController
    before_action :find_video
    before_action :find_like, only: [:destroy]
    before_action :authenticate_user!
    protect_from_forgery with: :null_session 
    
    def create
      like = @video.likes.find_by(user_id: current_user.id)
      if already_liked?
        render json: { status: "You have already liked it!", likeid: like }, status: :unprocessable_entity
      else
        if @video.user.likedvideonotifications == true
          notification = Notification.create(recipient: @video.user, actor: current_user, action: "liked", notifiable: @video)
          if notification.valid?
            notification.save
          end
        end
        @video.likes.create(user_id: current_user.id)
        render json: { status: "Video has been liked", likeid: like }, status: :created
      end
    end
  
    def destroy
      if !(already_liked?)
        render json: { status: "You have not liked this!" }, status: :unprocessable_entity
      else
        @like.destroy
        render json: { status: "Video has been unliked." }, status: :ok
      end
    end
  
    private
  
    def find_like
      @like = @video.likes.find(params[:id])
    end
  
    def already_liked?
      Like.where(user_id: current_user.id, video_id:
      params[:video_id]).exists?
    end
  
    def find_video
      @video = Video.find(params[:video_id])
    end
  end