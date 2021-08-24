class CommentsController < ApplicationController
    before_action :find_commentable
    before_action :find_comment, only: [:destroy, :edit, :update]
    before_action :authenticate_user!

    def create        
        if params[:comment][:parent_id]
            @comment = @commentable.comments.create(reply_params)
            ischild = true
        else
            @comment = @commentable.comments.create(comment_params)
            ischild = false
        end
        @comment.user_id = current_user.id
        if @comment.save
            if ischild == true
                if @comment.parent.user != current_user
                    if @comment.parent.user.replynotifications == true
                        notification = Notification.create(recipient: @comment.parent.user, actor: current_user, action: "Replied", notifiable: @comment)
                        if notification.valid?
                            notification.save
                        end
                    end
                end
                respond_to do |format|
                    format.js { render :child }
                    format.html { redirect_back(fallback_location: root_path) }
                end
            else
                if @commentable.user != current_user
                    if @commentable.user.commentnotifications == true
                        notification = Notification.create(recipient: @commentable.user, actor: current_user, action: "Commented", notifiable: @comment)
                        if notification.valid?
                            notification.save
                        end
                    end
                end
                respond_to do |format|
                    format.js { render :noparent }
                    format.html { redirect_back(fallback_location: root_path) }
                end
            end
        else
            flash[:alert] = "Check the comment form"
        end
    end

    def edit
    end

    def update
        @comment = @commentable.comments.find(params[:id])
        if @comment.user_id == current_user.id
            @comment.edited = true
            if params[:comment][:parent_id]
                @comment.update(reply_params)
            else
                @comment.update(comment_params)
            end
        end
        respond_to do |format|
            format.js { render :update }
            format.html { redirect_back(fallback_location: root_path) }
        end
    end

    def destroy
        @comment = @commentable.comments.find(params[:id])
        if @comment.user_id == current_user.id
            @comment.destroy
            respond_to do |format|
                format.js { render :delete }
                format.html { redirect_back(fallback_location: root_path) }
            end
        end
    end

    private 

    def comment_params
        params.require(:comment).permit(:body)
    end

    def reply_params
        params.require(:comment).permit(:body, :parent_id)
    end

    def find_comment
        @comment = @commentable.comments.find(params[:id])
    end

    def find_commentable
        @commentable = Video.find(params[:video_id])
    end
end
