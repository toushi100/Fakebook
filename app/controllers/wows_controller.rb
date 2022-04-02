class WowsController < ApplicationController
    def create
        @wow = current_user.wows.new(wow_params)
        @wow.save()
        redirect_to post_url(@wow.post_id)
    end

    def destroy
        @wow = current_user.wows.find(params[:id])
        @post = @wow.post
        @wow.destroy
        redirect_to post_url(@post)
    end

    private

    def wow_params
        params.require(:wow).permit(:post_id, :user_id)
    end
end
