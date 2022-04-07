class SadsController < ApplicationController
    def create
        post = Post.find(params['id'])
        @sad = post.sads.new()
        @sad.user_id = current_user.id

        @sad.save()
        redirect_to post_url(@sad.post_id)
    end

    def destroy
        @sad = current_user.sads.find(params[:id])
        @post = @sad.post
        @sad.destroy
        redirect_to post_url(@post)
    end

    private

    def sad_params
        params.require(:sad).permit(:post_id, :user_id)
    end
end
