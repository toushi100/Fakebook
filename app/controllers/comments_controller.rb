class CommentsController < ApplicationController
  @comments = Comment.all

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new()
    @comment.content = params["comment"]["content"]
    @comment.user_id = current_user.id
    @comment.save()
    redirect_to request.referrer
  end

  def destroy_comment
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
