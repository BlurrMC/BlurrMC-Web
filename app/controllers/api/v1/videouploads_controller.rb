class API::V1::VideouploadsController < ApplicationController
  respond_to :json
  before_action :authenticate_user!, only: [:create]
  protect_from_forgery with: :null_session

  def new
    @video = Video.new
  end

  def create
    # @video = Video.new(video_params.merge)
    @video = current_user.videos.build(video_params)
    # current_user.posts.build(params[:post])
    if @video.save
      render json: { status: 'Video Uploaded', video_id: @video.id }
    else
      render json: { status: 'Video could not upload' }
    end
  end

  def destroy
    @video = Video.find(params[:id])
    if @video.destroy
      render json: { status: 'Da video is gone just like the infinity stones!!!' }
    else
      render json: { status: 'Dang man, this video wasnt destroyed' }
    end
  end

  # def create
  #   @video = Video.new(video_params)
  #   if @video.save
  #     render json: { status: 'Video Uploaded' }
  #   else
  #     render json: {status: 'Video could not save'}, status: :not_found
  #   end
  # end

  private


  def video_params
    params.require(:video).permit(:description, :clip)
  end
end
