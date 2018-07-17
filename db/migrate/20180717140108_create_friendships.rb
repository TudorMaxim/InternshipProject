class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :status
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
