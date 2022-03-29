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
    
    redirect_to request.referrer 
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
    @deleteFirst.delete
    @deleteSecond.delete
    redirect_to request.referrer
  end

  def block_friend
    @block = BlockList.new
    @block.user_id = current_user.id
    @temp = User.find(params[:id])
    @block.blocked_friend_id = @temp.id
    
    @block.save

    @block = BlockList.new
    
    @temp = User.find(params[:id])
    @block.user_id = @temp.id
    @block.blocked_friend_id = current_user.id
    @block.blocked_status = true
    
    @block.save
    
    self.remove_friend
  end

  def un_block_friend
    BlockList.find_by_blocked_friend_id(params[:id]).delete
    BlockList.find_by_user_id(params[:id]).delete
    redirect_to request.referrer
  end

  def create_group
    @newGroup = Group.new
    @newGroup.name = params[:name]
    @newGroup.save


    redirect_to request.referrer
  end
  def edit_group
  end
  def update_group
  end
  def new_group
  end
end
