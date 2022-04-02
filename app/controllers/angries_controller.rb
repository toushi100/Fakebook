class AngriesController < ApplicationController
    def create
        @angry = current_user.angries.new(angry_params)
        @angry.save()
        redirect_to post_url(@angry.post_id)
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
