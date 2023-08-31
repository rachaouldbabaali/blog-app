require 'will_paginate/array'

class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[index show new create]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:user, comments: :user).order(created_at: :desc).paginate(page: params[:page],
                                                                                            per_page: 5)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.author_id)
    render 'show'
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(@user)
  end

  def new
    set_user
    @post = @user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      puts @post.errors.full_messages
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def authorize_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
end
