helpers do
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
    Follow.where(follow_id: user.id)
  end

end

