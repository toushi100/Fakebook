class AngriesController < ApplicationController
    def create
        post = Post.find(params['id'])
        @angry = post.angries.new()
        @angry.user_id = current_user.id
        @angry.save()
        redirect_to post_url(post)
    end

    def destroy
        @angry = current_user.angries.find(params[:id])
        @post = @angry.post
        @angry.destroy
        redirect_to post_url(@post)
    end

    private

    def angry_params
        params.require(:angry).permit(:post_id, :user_id)
    end
end
