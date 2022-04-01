class UsersController < ApplicationController
  def index #should be removed (3ashan da msh mawgood fel mawqe3 elli by2aldona feeh elli esmo facebook )
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
    redirect_to users_index_url
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

  def remove_friend_request
    Friendlist.find_by_friend_id(params[:id]).delete
    redirect_to request.referrer
  end

  def remove_friend
    @deleteFirst = Friendlist.find_by_user_id(params[:id])
    @deleteSecond = Friendlist.find_by_friend_id(params[:id])
    puts @deleteFirst.delete
    puts @deleteSecond.delete
    redirect_to request.referrer
  end

end
