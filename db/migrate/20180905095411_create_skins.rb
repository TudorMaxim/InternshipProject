class CreateSkins < ActiveRecord::Migration[5.2]
  def change
    create_table :skins do |t|
      t.string :name
      t.string :skin_type

      t.timestamps
    end
  end
end
