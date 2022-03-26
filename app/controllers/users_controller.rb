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

  def accept_friend_request
    @accept = Friendlist.find_by_friend_id(params[:id])
    @accept.update_attribute(:status , true)


    @invertfriend = Friendlist.new
    @invertfriend.user_id = current_user.id
    @temp = User.find(params[:id])
    @invertfriend.friend_id = @accept.user_id
    @invertfriend.status = true
    @invertfriend.save

    redirect_to request.referrer 

  end

end
