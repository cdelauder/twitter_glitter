helpers do
  include Rack::Utils
  alias_method :h, :escape_html


  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

  def following?(user)
    current_user.follows.where(user_id: user).any?
    # if current_user
    #   current_user.follows.each do |follow|
    #     if user.id == follow.follow_id
    #       return true
    #     end
    #   end
    #   return false
    # end
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
    @tweet_results = Tweet.where("content LIKE ?", "%#{query}%")
  end

end

