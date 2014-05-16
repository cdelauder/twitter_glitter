class User < ActiveRecord::Base
  has_many :tweets
  has_many :follows
  belongs_to :favorites
  validates :username, uniqueness: true
  validates :username, format: { with: /\A([a-zA-Z0-9]){6,}\Z/, message: "Oh Please! Usernames must be all letters and numbers, and at least 6 characters."}
  validates :name, :location, presence: true
  validates :password, length: {minimum: 6, message: "passwords need to be at least 6 characters"}
end
