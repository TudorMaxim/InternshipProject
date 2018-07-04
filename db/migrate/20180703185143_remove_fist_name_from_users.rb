class RemoveFistNameFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :fist_name
  end
end
