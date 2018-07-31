class Challenge < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  scope :played, -> { where(status: "accepted") }

  def set_winner(user)
    return false if self.status == "pending"
    user.update_attributes(victories: user.victories + 1)
    self.update_attributes( winner_id: user.id, finished_at: Time.now)
    return true
  end
end
