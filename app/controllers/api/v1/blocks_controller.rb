class API::V1::BlocksController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]
    protect_from_forgery with: :null_session 
    respond_to :json

    
    def create
      user = User.friendly.find(params[:id])
      if user == current_user
        render json: { status: 'You cannot block yourself!' }, status: :ok
      else
        if !current_user.blocking?(user)
            current_user.block(user)
            block = current_user.active_blocks.find_by(blocked_id: user.id)
            render json: { status: 'User has been blocked', blocked_id: block.id }, status: :created
        else
            block = current_user.active_blocks.find_by(blocked_id: user.id)
            render json: { status: 'User is already blocked', blocked_id: block.id }, status: :ok
        end
      end

    end

    def destroy
      user = Block.find(params[:id]).blocked
      @user = User.friendly.find(params[:username])
      if @user != current_user 
        if current_user.blocking?(user) 
          current_user.unblock(user)
          render json: { status: 'User has been unblocked' }, status: :ok
        else
          render json: { status: 'User has not been blocked' }, status: :ok
        end
      else
        render json: { status: 'You cannot unblock yourself' }, status: :ok
      end
    end
    
  end
  