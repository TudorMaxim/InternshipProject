class Challenge < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  scope :played, -> { where(status: "accepted") }

  def set_winner(user)
    return false if self.status == "pending" || user.nil?
    user.update_attributes(victories: user.victories + 1)
    self.update_attributes( winner_id: user.id, finished_at: Time.now)
    return true
  end

  def make_choice(user, choice)
    if user.id == self.sender_id
      self.update_attributes(sender_choice: choice)
    elsif user.id == self.receiver.id
      self.update_attributes(receiver_choice: choice)
    end
    w = self.find_winner
    self.set_winner w
  end

  def find_winner
    return nil if self.sender_choice.nil? || self.receiver_choice.nil? || self.sender_choice == self.receiver_choice
    return User.find_by(id: self.sender_id) if self.sender_choice == "rock" && self.receiver_choice == "scissors"
    return User.find_by(id: self.sender_id) if self.sender_choice == "paper" && self.receiver_choice == "rock"
    return User.find_by(id: self.sender_id) if self.sender_choice == "scissors" && self.receiver_choice == "paper"
    return User.find_by(id: self.receiver_id)
  end
end
