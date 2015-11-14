module UsersHelper

  def user_has_posts(user)
    user.posts.count >= 1
  end

  def user_has_comments(user)
    user.comments.count >= 1
  end

  def user_has_favorites(user)
    user.favorites.count >= 1
  end

end
