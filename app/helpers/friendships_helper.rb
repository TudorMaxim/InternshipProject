module FriendshipsHelper

  def find_friendship(friendship_id)
    f = current_user.friendships.find_by(id: friendship_id)
    if f.nil?
      f = current_user.inverse_friendships.find_by(id: friendship_id)
    end
    return f
  end

end
