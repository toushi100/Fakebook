class LikesController < ApplicationController

    def create
        @like = current_user.likes.new(like_params)
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
