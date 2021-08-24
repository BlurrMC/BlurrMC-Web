class LikesController < ApplicationController
  before_action :find_video
  before_action :find_like, only: [:destroy]
  before_action :authenticate_user!
  
  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @video.likes.create(user_id: current_user.id)
      if @video.user.likedvideonotifications == true
        @notification = Notification.create(recipient: @video.user, actor: current_user, action: "liked", notifiable: @video) 
        if @notification.valid?
          @notification.save
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to video_path(@video) }
      format.js
    end
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    respond_to do |format|
      format.html { redirect_to video_path(@video) }
      format.js
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