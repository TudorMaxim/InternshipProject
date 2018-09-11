class AddPriceToSkins < ActiveRecord::Migration[5.2]
  def change
    add_column :skins, :price, :decimal
  end
end
