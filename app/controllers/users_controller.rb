class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @most_recent_posts = @user.most_recent_posts
    @user_posts = @user.posts
  end
end
