class ReactsController < ApplicationController

    def create
        @react = current_user.reacts.new(react_params)
        @react.save()
        redirect_to post_url(@post)
    end

    def destroy
        @react = current_user.reacts.find(params[:id])
        @post = @react.post
        @react.destroy
        redirect_to post_url(@post)
    end

    private

    def react_params
        params.require(:react).permit(:post_id)
    end

end
