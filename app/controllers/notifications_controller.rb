class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(recipient: current_user).unread.newest.paginate(page: params[:page])
  end

  def mark_as_read
    if params[:id]
      @notfification.find_by(id: params[:id])
      @notfification.read
      render json: @notification
    else
      @notifications = Notification.where(recipient: current_user, action: "accepted your friend request").unread
      @notifications.update_all(read_at: Time.now)
      @unreadNotifications = Notification.where(recipient: current_user).unread
      render json: @unreadNotifications
    end
  end

end
