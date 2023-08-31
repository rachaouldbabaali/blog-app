class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(author_id: current_user.id) # Update this line

    if @like.save
      redirect_to user_post_path(current_user, @post), notice: 'Like was successfully added.'
    else
      redirect_to user_post_path(current_user, @post), alert: 'Failed to add like.'
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Like was successfully removed.'
  end
end
