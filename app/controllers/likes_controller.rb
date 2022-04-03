class LikesController < ApplicationController

    def create
        post = Post.find(params['id'])
        @like = post.likes.new()
        @like.user_id = current_user.id
        @like.save()
        redirect_to post_url(@like.post_id)
    end

    def destroy
        @like = current_user.likes.find(params[:id])
        @post = @like.post
        @like.destroy
        redirect_to post_url(@post)
        # redirect_to post
    end

    private

    def like_params
        params.require(:like).permit(:post_id, :user_id)
    end

end
