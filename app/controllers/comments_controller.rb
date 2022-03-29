class CommentsController < ApplicationController
  before_action :correct_user?, only: [:destroy_comment]

  @comments = Comment.all

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new()
    @comment.content = params["comment"]["content"]
    @comment.user_id = current_user.id
    @comment.save()
    redirect_to post_url(@post)
  end

  def destroy_comment
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
  
  
  def correct_user?
    @comment = Comment.find_by(id: params[:id])
    # unless current_user?(@comment.user)
    #     redirect_to request.referrer
    # end
    redirect_to post_url(@comment.post_id) unless @comment.user == current_user
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
