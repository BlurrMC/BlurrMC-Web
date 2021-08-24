class API::V1::SearchController < ApplicationController
    include Rails.application.routes.url_helpers
    respond_to :json
  
    def index
        search = params[:search].present? ? params[:search] : nil
        
        @users = if search
          User.search(search, page: params[:page], per_page: 15)
        else
          User.all.paginate(page: params[:page], per_page: 15)
        end

        @videos = if search
          Video.search(search, page: params[:page], per_page: 15)
        else
          Video.all.paginate(page: params[:page], per_page: 15)
        end
        if params[:search].start_with?("#")
          query = params[:search].gsub('#', '')
          @videos = Video.joins(:hash_tags).search(query, page: params[:page], per_page: 15) 
        else
          @videos = if search
            Video.search(params[:search], page: params[:page], per_page: 15)
          else
            Video.paginate(page: params[:page], per_page: 15)
          end
        end
    
    end
end
  