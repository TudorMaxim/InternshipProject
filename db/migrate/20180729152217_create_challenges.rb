class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :winner_id
      t.datetime :finished_at
      t.string :status, default: "pending"
      t.string :sender_choice
      t.string :receiver_choice

      t.timestamps
    end
  end
end
