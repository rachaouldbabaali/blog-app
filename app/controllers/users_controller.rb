class UsersController < ApplicationController
  def index
    @all_users = User.all
  end

  def show
    @user = User.includes(posts: [:user, { comments: :user }]).find(params[:id])
    @most_recent_posts = @user.most_recent_posts
    @user_posts = @user.posts
  end
end
