class Api::V1::PostsController < Api::V1::BaseController

  before_filter :authenticate_user, except: [:index, :show]
  before_filter :authorize_user, except: [:index, :show]

  def index
    # topics = Topic.all
    # render json: topics.to_json, status: 200
  end

  def show
    # topic = Topic.find(params[:id])
    # render json: topic.to_json, status: 200
    post = Post.find(params[:id])
    render json: { posts: post, comments: post.comments, votes: post.votes, favorites: post.favorites }


  end

  def update
    post = Post.find(params[:id])

    if post.update_attributes(post_params)
      render json: post.to_json, status: 200
    else
      render json: {error: "Post update failed", status: 400}, status: 400
    end

  end

  def create
    post = Post.new(post_params)

    if post.valid?
      post.save!
      render json: post.to_json, status: 201
    else
      render json: {error: "Post is invalid", status: 400}, status: 400
    end

  end

  def destroy
    post = Post.find(params[:id])

    if post.destroy
      render json: {message: "Post destroyed", status: 200}, status: 200
    else
      render json: {error: "Post destroy failed", status: 400}, status: 400
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
