class API::V1::NotificationSettingsController < ApplicationController
    before_action :authenticate_user!
    skip_forgery_protection with: :null_session 

    def index
    end


    def enablefollownotifications
        current_user.follownotifications = true
        if current_user.save
            render json: { status: "Everything set!" }
        else
            render json: { status: "Something went wrong :("}
        end
    end

    def disablefollownotifications
        current_user.follownotifications = false
        if current_user.save
            render json: { status: "Everything set!" }
        else
            render json: { status: "Something went wrong :("}
        end
    end

    def enablecommentnotifications
        current_user.commentnotifications = true
        if current_user.save
            render json: { status: "Everything set!" }
        else
            render json: { status: "Something went wrong :("}
        end
    end

    def disablecommentnotifications
        current_user.commentnotifications = false
        if current_user.save
            render json: { status: "Everything set!" }
        else
            render json: { status: "Something went wrong :("}
        end
    end

    def enablelikecommentnotifications
        current_user.likecommentnotification = true
        if current_user.save
            render json: { status: "Everything set!" }
        else
            render json: { status: "Something went wrong :("}
        end
    end

    def disablelikecommentnotifications
        current_user.likecommentnotification = false
        if current_user.save
            render json: { status: "Everything set!" }
        else
            render json: { status: "Something went wrong :("}
        end
    end

    def enablereplynotifications
        current_user.replynotifications = true
        if current_user.save
            render json: { status: "Everything set!" }
        else
            render json: { status: "Something went wrong :("}
        end
    end

    def disablereplynotifications
        current_user.replynotifications = false
        if current_user.save
            render json: { status: "Everything set!" }
        else
            render json: { status: "Something went wrong :("}
        end
    end

    def enablelikedvideonotifications
        current_user.likedvideonotifications = true
        if current_user.save
            render json: { status: "Everything set!" }
        else
            render json: { status: "Something went wrong :("}
        end
    end

    def disablelikedvideonotifications
        current_user.likedvideonotifications = false
        if current_user.save
            render json: { status: "Everything set!" }
        else
            render json: { status: "Something went wrong :("}
        end
    end

end