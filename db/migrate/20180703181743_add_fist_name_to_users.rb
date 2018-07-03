class AddFistNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :fist_name, :string
  end
end
