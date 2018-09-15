class RemoveUserIdFromConversations < ActiveRecord::Migration[5.2]
  def change
    remove_column :conversations, :user_id, :integer
  end
end
