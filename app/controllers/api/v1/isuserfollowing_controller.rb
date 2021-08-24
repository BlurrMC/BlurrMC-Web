class API::V1::IsuserfollowingController < ApplicationController
    respond_to :json
    before_action :authenticate_user!, only: [:show]
    protect_from_forgery with: :null_session 

    def show
        @user = User.friendly.find(params[:id])
        if @user != current_user 
            if !current_user.following?(@user)
                if !current_user.blocking?(@user)
                    render json: { status: 'User is not following or blocking' }
                else
                    block = current_user.active_blocks.find_by(blocked_id: @user.id)
                    render json: { status: 'User is not following but blocking', block_id: block.id  }, status: :ok
                end
            else
                if !current_user.blocking?(@user)
                    relationship = current_user.active_relationships.find_by(followed_id: @user.id )
                    render json: { status: 'User is following but not blocking', relationship_id: relationship.id }, status: :ok
                else
                    block = current_user.active_blocks.find_by(blocked_id: @user.id)
                    relationship = current_user.active_relationships.find_by(followed_id: @user.id )
                    render json: { status: 'User is following and blocking', relationship_id: relationship.id, block_id: block.id }
                end
            end
        else
            render json: { error: 'It is you!' }, status: :unauthorized
        end
    end
end
  