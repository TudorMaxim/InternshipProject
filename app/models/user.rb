class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # attr_accessor :first_name, :last_name, :admin, :banned, :victories, :email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
            format: {with: VALID_EMAIL_REGEX}

  has_many :notifications, foreign_key: :recipient_id

  has_many :friendships

  has_many :requested_friends,
            -> { where friendships: { status: "pending" } },
            :through => :friendships,
            :source => :friend

  has_many :accepted_requested_friends,
            -> { where friendships: { status: "accepted" } },
            :through => :friendships,
            :source => :friend

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  has_many :pending_friends,
            -> { where friendships: { status: "pending" } },
            :through => :inverse_friendships,
            :source => :user

  has_many :accepted_pending_friends,
            -> { where friendships: { status: "accepted" } },
            :through => :inverse_friendships,
            :source => :user



  def full_name
    "#{first_name} #{last_name}"
  end

  def invite(other_user)
    return false if other_user == self || find_any_friendship_with(other_user)
    f = self.friendships.build(friend_id: other_user.id)
    f.save
    Notification.create(recipient: other_user, actor: self, action: "sent you a friend request", notifiable: f)
  end

  def accept(other_user)
    f = find_any_friendship_with(other_user)
    return false if f.nil? || invited?(other_user)

    f.update_attributes(status: "accepted", accepted_at: Time.now)
    Notification.find_by(recipient: self, actor: other_user, action: "sent you a friend request", notifiable: f).read
    Notification.create(recipient: other_user, actor: self, action: "accepted your friend request", notifiable: f)
  end

  def unfriend(other_user)
    f = find_any_friendship_with(other_user)
    return false if f.nil?
    f.destroy
    self.reload && other_user.reload if f.destroyed?
    return true
  end

  def invited?(other_user)
    f = find_any_friendship_with(other_user)
    return false if f.nil?
    return f.friend_id == other_user.id
  end

  def friend_with?(other_user)
    f = find_any_friendship_with(other_user)
    return false if f.nil? || f.status != "accepted"
    return true
  end

  def friends
    return self.accepted_pending_friends + self.accepted_requested_friends
  end

  def friends_number
    return self.friends.count
  end

  def find_any_friendship_with(other_user)
    f = self.friendships.find_by(friend_id: other_user.id)
    if f.nil?
      f = self.inverse_friendships.find_by(user_id: other_user.id)
    end
    return f
  end
end
