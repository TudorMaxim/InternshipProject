class AddVictoriesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :victories, :integer
  end
end
