class BlocksController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]
    
    def create
      user = User.find(params[:blocked_id])
      current_user.block(user)
      # Shouldn't make notifications but consider it
      redirect_back(fallback_location: root_path)
    end

    def destroy
      user = Block.find(params[:id]).blocked
      current_user.unblock(user)
      redirect_back(fallback_location: root_path)
    end
    
  end
  