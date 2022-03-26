class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user = User.find_by_id(params[:id])
  end
  def send_friend_request
    @newfriend = Friendlist.new
    @newfriend.user_id = current_user.id
    @temp = User.find(params[:id])
    @newfriend.friend_id = @temp.id
    @newfriend.save

    # Notification for friend request

  end
end
