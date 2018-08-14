class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  include FriendshipsHelper

  def create
    if current_user.invite(User.find(params[:friend_id]))
      flash[:notice] = "Friend request succesfully sent"
      redirect_to root_url
    else
      flash[:danger] = "Unable to send friend request"
      redirect_to root_url
    end
  end

  def update
    @friendship = find_friendship(params[:id])
    if current_user.accept(User.find_by(id: @friendship.user_id))
      flash[:notice] = "Friend request succesfully accepted"
      redirect_to root_url
    else
      flash[:danger] = "Unable to accept friend request"
      redirect_to root_url
    end
  end

  def destroy
    @friendship = find_friendship(params[:id])
    Notification.find_by(notifiable_id: @friendship.id, notifiable: @friendship).read
    @friendship.destroy

    flash[:notice] = "You are no longer friends"
    redirect_to current_user
  end

  def index
    @my_friends = nil
    if params[:search].nil?
      @my_friends = current_user.friends.paginate(page: params[:page])
    else
      @my_friends = current_user.friends_filtered(params[:search]).paginate(page: params[:page])
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

end
