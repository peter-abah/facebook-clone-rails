class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comments_params)

    if @comment.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comments_params)
      redirect_to @comment.post
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
  end

  private

    def comments_params
      params.require(:comment).permit(:body, :user_id)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end
end
