class CommentsController < ApplicationController

     @comments = Comment.all


    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(params[:comment].permit(:content, :post_id, :user_id))
        @comment = current_user.comments.new(comment_params)
        redirect_to post_path(params[:post_id])
    end

    def destroy_comment
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :post_id, :user_id)
    end

end
