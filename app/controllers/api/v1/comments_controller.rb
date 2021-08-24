class API::V1::CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_commentable
    protect_from_forgery with: :null_session
    before_action :find_comment, only: [:destroy, :update, :edit]

    def index
        @comments = @commentable.comments.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end # Make it show if comment is reply
    
    def create
        if params[:comment][:parent_id]
            @comment = @commentable.comments.create(reply_params)
        else
            @comment = @commentable.comments.create(comment_params)
        end
        @comment.user_id = current_user.id
        if @comment.save
            render json: { status: 'Comment has been made' }
        else
            render json: { status: @comment.errors }, status: :unprocessable_entity 
        end
    end

    def destroy
        @comment = @commentable.comments.find(params[:id])
        if @comment.user_id == current_user.id
            @comment.destroy
            render json: { status: 'Comment Destroyed!' }
        else
            render json: { status: 'This comment is not yours!'}, status: :forbidden
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
                if @comment.parent.user.replynotifications == true
                    notification = Notification.create(recipient: @comment.parent.user, actor: current_user, action: "Replied", notifiable: @comment)
                    if notification.valid?
                        notification.save
                    end
                end
            else
                @comment.update(comment_params)
                if @commentable.user.commentnotifications == true
                    notification = Notification.create(recipient: @commentable.user, actor: current_user, action: "Commented", notifiable: @comment)
                    if notification.valid?
                        notification.save
                    end
                end
            end
            render json: { status: 'Comment updated.' }
        else
            render json: { status: 'This comment is not yours!'}, status: :forbidden
        end
    end

    private

    def reply_params
        params.require(:comment).permit(:body, :parent_id)
    end

    def find_commentable
        @commentable = Video.find(params[:video_id])
    end

    def find_comment
        @comment = @commentable.comments.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:body)
    end
end