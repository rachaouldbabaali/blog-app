class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user_and_post

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])

    @comment = @post.comments.new(comment_params)
    @comment.author_id = @user.id # Update this line

    if @comment.save
      redirect_to request.referrer
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      redirect_to user_post_path(@user, @post), notice: 'Comment deleted Successfully'
    else
      redirect_to user_post_path(@user, @post), alert: 'Failed to delete comment!'
    end
  end

  private

  def set_user_and_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
