class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  has_many :tweets
  has_many :follows
  belongs_to :favorites
  validates :username, uniqueness: true
  validates :username, format: { with: /\A([a-zA-Z0-9]){6,}\Z/, message: "Oh Please! Usernames must be all letters and numbers, and at least 6 characters."}
  validates :name, :password, :location, presence: true
  validates :password, length: {minimum: 6, message: "passwords need to be at least 6 characters"}

  def is_following?(user)
    current_user.follows.where(user_id: user).any?
  end

  def follows_feed
    current_user.follows.map { |follow| follow.tweets }.sort_by(&:created_at).reverse
  end

  def followers
    followers = Follow.where(follow_id: self.id)
    followers.map { |follower| User.find(follower.user_id) }
  end
end
