class CsController < ApplicationController
  skip_before_action :configure_permitted_parameters, only: [:show, :my_channel]
  before_action :authenticate_user!, only: [:my_channel, :follow, :unfollow]

  def autocomplete
    #@videos = Video.search(params[:query], {
    #  fields: ["description"],
    #  limit: 10
    #})
    #respond_to do |format|
    #  format.json
    #end
    # More modern?
    #search = params[:query].present? ? params[:query] : nil
    #  if search.start_with?("#")
    #    query = search.gsub('#', '')
    #    @videos = Video.joins(:hash_tags).search(search, {
    #      fields: ["description"],
    #      limit: 10
    #      })
    #  else
    #    @videos = if search 
    #      @videos = Video.search(search, {
    #        fields: ["description"],
    #        limit: 10
    #        })
    #    end
    #  end
    #  @users = if search
    #    if search.start_with?('@')
    #      @videos = []
    #    end
    #    @users = User.search(search, {
    #      fields: ["username"],
    #      limit: 10
    #      })
    #  end
    #  respond_to do |format|
    #    format.json
    #  end
    render json: Video.search(params[:query], {
      fields: ["description"],
      limit: 10
      }).map(&:description)
      
  end
  
  def show
    @user = User.friendly.find(params[:id])
    @videos = @user.videos.order(created_at: :desc)
  end

  def follow
    @user = User.find(params[:id])
    current_user.following(@user)
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.stop_following(@user)
  end

  def index
    search = params[:search].present? ? params[:search] : nil
    @users = if search
      User.search(search, page: params[:page], per_page: 10)
    else
      User.paginate(page: params[:page], per_page: 15)
    end
    if params[:search].start_with?("#")
      query = params[:search].gsub('#', '')
      @videos = Video.joins(:hash_tags).search(query, page: params[:page], per_page: 10) 
    else
      @videos = if search
        Video.search(params[:search], page: params[:page], per_page: 10)
      else
        Video.paginate(page: params[:page], per_page: 15)
      end
      respond_to do |format|
        format.html
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
