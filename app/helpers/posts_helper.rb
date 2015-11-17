module PostsHelper

  def user_is_authorized_for_post?(post)
    current_user && (current_user == post.user || current_user.admin?)
  end

  # def total_votes(post)
  #   total_votes = post.votes.up_votes.count + post.votes.down_votes.count
  # end

end
