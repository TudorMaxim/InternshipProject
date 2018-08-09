class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(recipient: current_user).unread.newest.paginate(page: params[:page])
  end
end
