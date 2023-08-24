class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @all_posts = @user.posts.includes(:user, comments: :user)
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end
end
