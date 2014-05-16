helpers do
  include Rack::Utils
  alias_method :h, :escape_html


  def current_user
    User.find(session[:user_id])
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

