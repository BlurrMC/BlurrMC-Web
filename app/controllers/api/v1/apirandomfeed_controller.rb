class API::V1::ApirandomfeedController < ApplicationController
    before_action :authenticate_user!
    protect_from_forgery with: :null_session 
    respond_to :json

    def create
        @videos = Video.order(Arel.sql('RANDOM()')).paginate(page: params[:page], per_page: 5)
    end

end