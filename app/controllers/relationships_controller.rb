class RelationshipsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  def create
    @user = User.friendly.find(params[:user])
    current_user.follow(@user)
    # Create notifications
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
    if @user.follownotifications == true
      notification = Notification.create(recipient: @user, actor: current_user, action: "followed", notifiable: current_user)
      if notification.valid?
        notification.save
      end
    end
  end
end
