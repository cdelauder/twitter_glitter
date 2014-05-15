class User < ActiveRecord::Base
  has_many :tweets
  has_many :follows
  validates :username, uniqueness: true 
  validates :username, format: { with: /\A([a-zA-Z0-9]){6,}\Z/, message: "Oh Please! Usernames must be all letters and numbers, and at least 6 characters."}
end
