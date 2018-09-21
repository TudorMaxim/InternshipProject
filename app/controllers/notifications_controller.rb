class NotificationsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(recipient: current_user).unread.newest.paginate(page: params[:page])
  end

  def mark_as_read
    @notifications = Notification.where(recipient: current_user, action: "accepted your friend request!").unread
    @notifications.update_all(read_at: Time.now)
    @notifications = Notification.where(recipient: current_user).unread.newest
    render "index"
  end

end
