class Challenge < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  scope :played, -> { where(status: "accepted") }
end
