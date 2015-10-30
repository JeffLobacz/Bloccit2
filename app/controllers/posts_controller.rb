class PostsController < ApplicationController

  # Create distinction between guest and member:
  before_action :require_sign_in, except: :show

  # Create distinction between member and moderator:
  before_action :authorize_moderator, except: [:show, :new, :create]

  # Create distinction between moderator and admin:
  before_action :authorize_admin, only: [:destroy]


  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_moderator
    post = Post.find(params[:id])
    unless current_user == post.user || current_user.admin? || current_user.moderator?
      flash[:error] = "You must be a moderator or an admin to do that."
      redirect_to [post.topic, post]
    end
  end

  def authorize_admin
    post = Post.find(params[:id])
    unless current_user == post.user || current_user.admin?
      flash[:error] = "You must be an admin to do that."
      redirect_to [post.topic, post]
    end
  end

end
