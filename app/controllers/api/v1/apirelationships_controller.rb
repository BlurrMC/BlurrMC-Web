class API::V1::ApirelationshipsController < ApplicationController
    respond_to :json
    before_action :authenticate_user!, only: [:create, :destroy]
    protect_from_forgery with: :null_session 
    
    def create
        user = User.friendly.find(params[:id])
        if user != current_user 
            if !current_user.following?(user)
                current_user.follow(user)
                relationship = current_user.active_relationships.find_by(followed_id: user.id)
                if user.follownotifications == true
                    notification = Notification.create(recipient: user, actor: current_user, action: "followed", notifiable: current_user)
                    if notification.valid?
                        notification.save
                    end
                end
                render json: { status: 'User Followed', relationship_id: relationship.id }, status: :created
            else
                relationship = current_user.active_relationships.find_by(followed_id: user.id)
                render json: { status: 'User already followed!', relationship_id: relationship.id }, status: :ok
            end
        else
            render json: { status: 'You cannot follow yourself!' }, status: :ok
        end
    end

    def destroy
        user = Relationship.find(params[:id]).followed
        @user = User.friendly.find(params[:username])
        if @user != current_user 
            if current_user.following?(@user) 
                current_user.unfollow(user)
                render json: { status: 'User unfollowed' }, status: :ok
            else
                render json: { status: 'User is not followed!' }, status: :ok
            end
        else
            render json: { status: 'You cannot unfollow yourself!' }, status: :ok
        end
    end
end
  