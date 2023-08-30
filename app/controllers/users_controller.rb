class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @all_users = User.all
  end

  def show
    if params[:id] == 'sign_out'
      sign_out_and_redirect
    else
      @user = User.includes(posts: [:user, { comments: :user }]).find(params[:id])
      @most_recent_posts = @user.most_recent_posts
      @user_posts = @user.posts
      redirect_to users_path, alert: 'User not found' unless @user
    end
  end

  def sign_out_and_redirect
    sign_out current_user
    redirect_to new_user_session_path
  end
end
