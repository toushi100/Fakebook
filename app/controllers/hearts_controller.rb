class HeartsController < ApplicationController
    def create
        @heart = current_user.hearts.new(heart_params)
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
