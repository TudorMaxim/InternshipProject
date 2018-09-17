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

  has_many :skins
  
  has_many :notifications, foreign_key: :recipient_id

  has_many :messages
  has_many :conversations, foreign_key: :sender_id

  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  has_many :requested_friends, -> { where friendships: { status: "pending" } },
            :through => :friendships, :source => :friend

  has_many :accepted_requested_friends, -> { where friendships: { status: "accepted" } },
            :through => :friendships, :source => :friend

  has_many :pending_friends, -> { where friendships: { status: "pending" } },
            :through => :inverse_friendships, :source => :user

  has_many :accepted_pending_friends, -> { where friendships: { status: "accepted" } },
            :through => :inverse_friendships, :source => :user


  has_many :challenges, class_name: "Challenge", foreign_key: "sender_id"
  has_many :inverse_challenges, class_name: "Challenge", foreign_key: "receiver_id"

  has_many :sent_to_challenges, -> { where challenges: {status: "pending" } },
           through: :challenges, source: :receiver

  has_many :accepted_sent_to_challenges, -> { where challenges: {status: "accepted" } },
           through: :challenges, source: :receiver

  has_many :received_from_challenges, -> {where challenges: { status: "pending" } },
           through: :inverse_challenges, source: :sender

  has_many :accepted_received_from_challenges, -> { where challenges: { status: "accepted" } },
           through: :inverse_challenges, source: :sender


  def self.search(what)
    if what
      self.where("first_name LIKE ? OR last_name LIKE ?", "%#{what}%", "%#{what}%")
    else
      all
    end
  end


  def friends_filtered(what)
    return self.friends.select {|f| (f.first_name.downcase[what.downcase] || f.last_name.downcase[what.downcase]) }
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def invite(other_user)
    return false if other_user == self || find_any_friendship_with(other_user)
    f = self.friendships.build(friend_id: other_user.id)
    f.save
    Notification.create(recipient: other_user, actor: self, action: "sent you a friend request!", notifiable: f)
    return true
  end

  def accept(other_user)
    f = find_any_friendship_with(other_user)
    return false if f.nil? || invited?(other_user)

    f.update_attributes(status: "accepted", accepted_at: Time.now)
    Notification.find_by(recipient: self, actor: other_user, action: "sent you a friend request!", notifiable: f).read
    Notification.create(recipient: other_user, actor: self, action: "accepted your friend request!", notifiable: f)
    return true
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
    self.accepted_pending_friends + self.accepted_requested_friends
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


  def challenge(other_user)
    return false if other_user == self || find_any_game_with(other_user)
    c = self.challenges.build(receiver_id: other_user.id)
    c.save
    Notification.create(recipient: other_user, actor: self, action: "challenged you!", notifiable: c)
    return true
  end

  def accept_challenge(other_user)
    c = find_any_game_with(other_user)
    return false if c.nil? || challenged?(other_user) || c.status == "accepted"
    c.update_attributes(status: "accepted")
    Notification.find_by(recipient: self, actor: other_user, action: "challenged you!", notifiable: c).read
    Notification.create(recipient: other_user, actor: self, action: "accepted your challenge!", notifiable: c)
    return true
  end

  def decline_challenge(other_user)
    c = find_any_game_with(other_user)
    return false if c.nil?
    c.destroy
    self.reload && other_user.reload if c.destroyed?
    return true
  end

  def played_games
    arr = self.challenges.played + self.inverse_challenges.played
    arr.sort! { |l, r| r.finished_at <=> l.finished_at }
    return arr
  end

  def challenged?(other_user)
    c = find_any_game_with(other_user)
    return false if c.nil?
    return c.receiver_id == other_user.id
  end

  def find_any_game_with(other_user)
    g = self.challenges.find_by(receiver_id: other_user.id, status: "pending")
    if g.nil?
      g = self.inverse_challenges.find_by(sender_id: other_user.id, status: "pending")
    end
    return g
  end

  def all_conversations
    Conversation.where("user_id = ? OR friend_id = ? ", self.id, self.id).order(updated_at: :desc)
  end

  def find_any_conversation_with(other_user)
    c = self.conversations.find_by(friend_id: other_user.id)
    if c.nil?
      c = self.inverse_conversations.find_by(user_id: other_user.id)
    end
    return c
  end
end
