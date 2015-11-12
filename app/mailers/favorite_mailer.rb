class FavoriteMailer < ApplicationMailer
  default from: "jeff.lobacz@gmail.com"

  def new_comment(user, post, comment)

    headers["Message-ID"] = "<comments/#{comment.id}@jefflobacz-bloccit2.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@jefflobacz-bloccit2.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@jefflobacz-bloccit2.herokuapp.com>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on: #{post.title}")
  end

  def new_post(user, post)

    headers["Message-ID"] = "<post/#{post.id}@jefflobacz-bloccit2.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@jefflobacz-bloccit2.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@jefflobacz-bloccit2.herokuapp.com>"

    @user = user
    @post = post

    mail(to: user.email, subject: "Favorited upon creation: #{post.title}")
  end

end
