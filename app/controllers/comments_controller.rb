class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)

    @comment.save

    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end

end
