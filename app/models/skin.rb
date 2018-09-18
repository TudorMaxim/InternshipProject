class Skin < ApplicationRecord
  has_attached_file :image, styles: { medium: "200x200>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true, uniqueness: true
  validates :skin_type, presence: true
  validates :price, presence: true
  validates :image, presence: true

end
