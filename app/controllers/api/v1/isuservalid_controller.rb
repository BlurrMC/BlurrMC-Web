class API::V1::IsuservalidController < ApplicationController
    respond_to :json
    before_action :authenticate_user!, only: [:show]
    protect_from_forgery with: :null_session 
    def show
        @user = User.friendly.find(params[:id])
        if @user == current_user 
            render json: { status: 'User is valid! YAY :)' }, status: :ok
        else
            render json: { error: 'User is not valid. Oh no!' }, status: :unauthorized
        end
    end
end
  