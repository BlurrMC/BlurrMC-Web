class ErrorsController < ApplicationController
    respond_to :html, :json


    def show
        status_code = params[:code] || 500
        @errorcode = "Status #{status_code}"
    end
end
