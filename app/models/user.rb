class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # attr_accessor :first_name, :last_name, :admin, :banned, :victories, :email
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

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
  end

  def accept(other_user)
    f = find_any_friendship_with(other_user)
    return false if f.nil? || invited?(other_user)
    f.update_attributes(status: "accepted", accepted_at: Time.now)
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
