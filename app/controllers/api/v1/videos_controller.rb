class API::V1::VideosController < ApplicationController
    include Rails.application.routes.url_helpers
    before_action :authenticate_user!, only: [:destroy]
    protect_from_forgery with: :null_session, only: [:destroy]

    respond_to :json
    def show
      @video = Video.find(params[:id])
    end

    def destroy
      @video = Video.find(params[:id])
      if @video.user == current_user
        @video.destroy
        render json: { status: 'The video has been destroyed, sad.' }
      else
        render json: { error: 'You dont own the video! WHY?!' }
      end
    end
end
