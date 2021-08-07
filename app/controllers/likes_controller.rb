class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create!(like_params)

    redirect_to @post
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to posts_url
  end
end
