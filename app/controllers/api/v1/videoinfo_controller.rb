class API::V1::VideoinfoController < ApplicationController
    include Rails.application.routes.url_helpers

    respond_to :json

    def show
      @video = Video.find(params[:id])
    end
end
