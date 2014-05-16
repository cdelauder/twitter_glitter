helpers do
  include Rack::Utils
  alias_method :h, :escape_html


  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

  def get_feed
    user = User.find(session[:user_id])
    following_these_ids = user.follows.map {|follow| follow.follow_id}
    if following_these_ids.any?
      tweets_of_following = following_these_ids.map do |user_id|
      Tweet.where(user_id: user_id)
      end
    end
    @sorted_feed = tweets_of_following.flatten.sort_by &:created_at
    @sorted_feed.reverse!
  end

  def following?(user)
    current_user.follows.each do |follow|
      if user.id == follow.follow_id
        return true
      end
    end
    return false
  end

  def following(follow)
    User.find(follow.follow_id)
  end

  def followers(user)
    followers = Follow.where(follow_id: user.id)
    followers = followers.map do |follower|
      User.find(follower.user_id)
    end
    followers
  end

  def search(query)
    @user_results = User.where("username LIKE ?", "%#{query}%")
    p @user_results
    @tweet_results = Tweet.where("content LIKE ?", "%#{query}%")
    p @tweet_results
  end

end

