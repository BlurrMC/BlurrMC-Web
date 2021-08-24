class API::V1::CommentlikesController < ApplicationController
    before_action :find_comment
    before_action :find_like, only: [:destroy]
    before_action :authenticate_user!
    protect_from_forgery with: :null_session 
    
    def create
      if already_liked?
        like = @comment.commentlikes.find_by(user_id: current_user.id)
        render json: { status: "You have already liked it!", likeid: like.id }, status: :unprocessable_entity
      else
        @comment.commentlikes.create(user_id: current_user.id)
        like = @comment.commentlikes.find_by(user_id: current_user.id)
        if @comment.user.likedvideonotifications == true
          notification = Notification.create(recipient: @comment.user, actor: current_user, action: "Liked comment", notifiable: @comment)
          if notification.valid?
            notification.save
          end
        end
        render json: { status: "Video has been liked", likeid: like.id }, status: :created
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
      @like = @comment.commentlikes.find(params[:id])
    end
  
    def already_liked?
      Commentlike.where(user_id: current_user.id, comment_id:
      params[:comment_id]).exists?
    end
  
    def find_comment
      @video = Video.find(params[:video_id])
      @comment = @video.comments.find(params[:comment_id])
    end
  end