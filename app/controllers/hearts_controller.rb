class HeartsController < ApplicationController
    def create
        post = Post.find(params['id'])
        @heart = post.hearts.new()
        @heart.user_id = current_user.id
        @heart.save()
        redirect_to post_url(@heart.post_id)
    end

    def destroy
        @heart = current_user.hearts.find(params[:id])
        @post = @heart.post
        @heart.destroy
        redirect_to post_url(@post)
    end

    private

    def heart_params
        params.require(:heart).permit(:post_id, :user_id)
    end
end
