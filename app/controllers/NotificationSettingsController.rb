class NotificationSettingsController < ApplicationController
    before_action :authenticate_user!

    def index
    end

    def enablefollownotifications
        current_user.follownotifications = true
        current_user.save!
        respond_to do |format|
            format.html { redirect_back(fallback_location: root_path) }
            format.js
        end
    end

    def disablefollownotifications
        current_user.follownotifications = false
        current_user.save!
        respond_to do |format|
            format.html { redirect_back(fallback_location: root_path) }
            format.js
        end
    end

    def enablecommentnotifications
        current_user.commentnotifications = true
        current_user.save!
        respond_to do |format|
            format.html { redirect_back(fallback_location: root_path) }
            format.js
        end
    end

    def disablecommentnotifications
        current_user.commentnotifications = false
        current_user.save!
        respond_to do |format|
            format.html { redirect_back(fallback_location: root_path) }
            format.js
        end
    end

    def enablelikecommentnotifications
        current_user.likecommentnotification = true
        current_user.save!
        respond_to do |format|
            format.html { redirect_back(fallback_location: root_path) }
            format.js
        end
    end

    def disablelikecommentnotifications
        current_user.likecommentnotification = false
        current_user.save!
        respond_to do |format|
            format.html { redirect_back(fallback_location: root_path) }
            format.js
        end
    end

    def enablereplynotifications
        current_user.replynotifications = true
        current_user.save!
        respond_to do |format|
            format.html { redirect_back(fallback_location: root_path) }
            format.js
        end
    end

    def disablereplynotifications
        current_user.replynotifications = false
        current_user.save!
        respond_to do |format|
            format.html { redirect_back(fallback_location: root_path) }
            format.js
        end
    end

    def enablelikedvideonotifications
        current_user.likedvideonotifications = true
        current_user.save!
        respond_to do |format|
            format.html { redirect_back(fallback_location: root_path) }
            format.js
        end
    end

    def disablelikedvideonotifications
        current_user.likedvideonotifications = false
        current_user.save!
        respond_to do |format|
            format.html { redirect_back(fallback_location: root_path) }
            format.js
        end
    end

end