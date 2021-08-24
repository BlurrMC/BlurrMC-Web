class API::V1::ChannelsController < ApplicationController
  include Rails.application.routes.url_helpers
  respond_to :json

  def show
    @user = User.friendly.find(params[:id])
    @videos = Video.all
  end
end
