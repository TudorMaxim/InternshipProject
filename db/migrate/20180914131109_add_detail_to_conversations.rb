class AddDetailToConversations < ActiveRecord::Migration[5.2]
  def change
    add_reference :conversations, :friend, foreign_key: true
  end
end
