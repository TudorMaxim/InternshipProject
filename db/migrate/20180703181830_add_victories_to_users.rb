class AddVictoriesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :victories, :integer, default: 0
  end
end
