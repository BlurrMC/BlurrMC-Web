class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :create, :update, :destroy]
  # protect_from_forgery except: :show 

  respond_to :js, :html

  def index
    @videos = Video.all
    respond_with(@videos)
  end

  def show
    #respond_with(@video)
    @video = @video
    respond_to do |format|
      format.html
      format.js
    end
    impressionist(@video)
  end

  def new
    @video = Video.new
    respond_with(@video)
  end

  def edit
  end

  def create
    # @video = Video.new(video_params.merge)
    @video = current_user.videos.build(video_params)
    # current_user.posts.build(params[:post])
    @video.save
    respond_with(@video)
  end

  def update
    @video.update(video_params)
    respond_with(@video)
  end

  def destroy
    #@video.destroy
    @video = @video
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:description, :clip)
    end
end
