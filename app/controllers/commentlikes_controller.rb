class CommentlikesController < ApplicationController # Maybe save on the extra model and just make a polymorphic relationship
    before_action :find_commentable
    before_action :find_like, only: [:destroy]
    before_action :authenticate_user!
    
    def create
      if already_liked?
        flash[:notice] = "You can't like more than once"
      else
        @comment.commentlikes.create(user_id: current_user.id)
        if @comment.user.likedvideonotifications == true
          notification = Notification.create(recipient: @comment.user, actor: current_user, action: "Liked comment", notifiable: @comment)
          if notification.valid?
            notification.save
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
      @like = @comment.commentlikes.find(params[:id])
    end
  
    def already_liked?
      Commentlike.where(user_id: current_user.id, comment_id:
      params[:comment_id]).exists?
    end
  
    def find_commentable
      @commentable = Video.find(params[:video_id]) 
      @comment = @commentable.comments.find(params[:comment_id])
    end

end