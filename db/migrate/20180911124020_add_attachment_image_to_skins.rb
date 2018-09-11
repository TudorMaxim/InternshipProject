class AddAttachmentImageToSkins < ActiveRecord::Migration[5.2]
  def up
    add_attachment :skins, :image
  end

  def down
    remove_attachment :skins, :image
  end
end
