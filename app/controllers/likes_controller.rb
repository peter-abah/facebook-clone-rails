class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create!(like_params)

    redirect_back fallback_location: posts_path
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_back fallback_location: posts_path
  end

  def like_params
    params.require(:like).permit(:user_id)
  end
end
