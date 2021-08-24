class RemoverelationshipsController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def create
        @user = User.friendly.find(params[:user])
        #user = Relationship.find(@user.id).followed
        current_user.unfollow(@user)
        respond_to do |format|
            format.html { redirect_back(fallback_location: root_path) }
            format.js
        end
    end
end