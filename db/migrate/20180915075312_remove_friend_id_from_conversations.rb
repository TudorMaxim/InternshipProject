class RemoveFriendIdFromConversations < ActiveRecord::Migration[5.2]
  def change
    remove_column :conversations, :friend_id, :integer
  end
end
