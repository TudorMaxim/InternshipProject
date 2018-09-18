class AddAttachmentImageToBoughtSkins < ActiveRecord::Migration[5.2]
  def self.up
    change_table :bought_skins do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :bought_skins, :image
  end
end
