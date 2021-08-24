require 'will_paginate/array'

class HomeController < ApplicationController
  def index
    search = params[:term].present? ? params[:term] : nil
    if user_signed_in?
      @videos = Video.of_followed_users(current_user.following).order('created_at DESC').paginate(page: params[:page], per_page: 5)
    end
    videos = Video.all
    randomvideos = videos.sort_by { |video| [
      video.likes.where(updated_at: 24.hours.ago..Time.now) ? 0: 1,
      video.impressionist_count(:filter=>:ip_address, :start_date => 24.hours.ago),
      video.created_at,
      video.comments.count,
      video.user.followers.count,
      video.likes.where(updated_at: 72.hours.ago..Time.now)
    ]} # Change these options to get different results
    @randomvideos = randomvideos.paginate(page: params[:page], per_page: 5)
    # or @randomvideos = Video.order(Arel.sql('RANDOM()')).paginate(page: params[:page], per_page: 5)
  end
  def autocomplete
    render json: User.search(params[:query], {
      fields: ["username"],
      match: :wordstart,
      limit: 10,
      load: false,
      misspellings: {below: 5}
    }).map(&:username)
  end
end