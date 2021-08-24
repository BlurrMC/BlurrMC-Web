class API::V1::ChannelsfollowingController < ApplicationController
  include Rails.application.routes.url_helpers
  skip_before_action :configure_permitted_parameters, only: [:show]
  respond_to :json

  def show
    @user = User.friendly.find(params[:id])
    @following = @user.following.paginate(page: params[:page], per_page: 50)
  end

end
