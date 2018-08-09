class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read_at: nil) }
  scope :newest, -> { order(:created_at).reverse_order }

  def read
    self.update_attributes(read_at: Time.now)
  end

end
