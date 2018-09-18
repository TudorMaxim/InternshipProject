class CreateBoughtSkins < ActiveRecord::Migration[5.2]
  def change
    create_table :bought_skins do |t|
      t.integer :user_id
      t.string :name
      t.string :skin_type
      t.boolean :selected, default: false

      t.timestamps
    end
  end
end
