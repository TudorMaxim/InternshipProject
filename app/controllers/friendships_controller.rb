class FriendshipsController < ApplicationController
  def create
    if current_user.invite(User.find(params[:friend_id]))
      flash[:notice] = "Friend request succesfully sent"
      redirect_to root_url
    else
      flash[:notice] = "Unable to send friend request"
      redirect_to root_url
    end
  end

  def destroy
    @friendship = current_user.friendships.find_by(id: params[:id])
    if @friendship.nil?
      @friendship = current_user.inverse_friendships.find_by(id: params[:id])
    end
    @friendship.destroy
    flash[:notice] = "You are no longer friends"
    redirect_to current_user
  end

  def index
    @my_friends = current_user.friends.paginate(page: params[:page])
  end

end
