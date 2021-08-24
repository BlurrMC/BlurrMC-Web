class API::V1::NotificationsController < ApplicationController
  before_action :authenticate_user!
  skip_forgery_protection with: :null_session
  respond_to :json 

  def index
    @notifications = Notification.where(recipient: current_user).recent.paginate(page: params[:page], per_page: 25)
  end

  def mark_as_read
      @notifications = Notification.where(recipient: current_user).unread
      @notifications.update_all(read_at: Time.zone.now)
      render json: { status: "success"}
  end

  def unread_count
    @notifications = Notification.where(recipient: current_user).unread
    render json: { count: @notifications.count }
  end
  
end
