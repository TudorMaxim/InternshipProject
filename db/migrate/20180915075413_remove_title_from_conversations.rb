class RemoveTitleFromConversations < ActiveRecord::Migration[5.2]
  def change
    remove_column :conversations, :title, :string
  end
end
