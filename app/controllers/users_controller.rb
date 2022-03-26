class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user = User.find_by_id(params[:id])
  end
  def send_friend_request
    friendlist = new Friendlist()
    friendlists.user_id = current_user
    friendlists.friend_id = User.find(params[:id])
    Friendlist.save()

    # Notification for friend request

  end
end
