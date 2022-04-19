class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_privacy
  
  def index
    @users=[]
    users = User.all
    users.each{
      |user|
      unless user == current_user
        unless user.friends.where(id: current_user.id).count > 0 or current_user.friends.where(id: user.id).count > 0
          unless user.blocked_friend.where(id: current_user.id).count > 0 or current_user.blocked_friend.where(id: user.id).count > 0
            @users.append(user)
          end
        end
      end
    }
  end

  def show
    @user = User.find_by_id(params[:id])
    if @user == nil
      redirect_to not_found_path
      return
    end 
    @groups = @user.user_groups
  end

  def friends
    @user = User.find_by_id(params[:profile_id])
  end

  def groups
    @user = User.find_by_id(params[:profile_id])
  end

  def send_friend_request
    if user_signed_in?
      @newfriend = Friendlist.new
      @newfriend.user_id = current_user.id
      @temp = User.find(params[:id])
      @newfriend.friend_id = @temp.id
      @newfriend.save
      redirect_to users_index_url
    else
      redirect_to new_user_session_url
    end
  end

  def accept_friend_request
    @accept = Friendlist.find_by_friend_id(params[:id])
    @accept.update_attribute(:status, true)
    @invertfriend = Friendlist.new
    @invertfriend.user_id = current_user.id
    @temp = User.find(params[:id])
    @invertfriend.friend_id = @accept.user_id
    @invertfriend.status = true
    @invertfriend.save
  end

  def remove_friend_request
    Friendlist.find_by_friend_id(params[:id]).delete
    redirect_to user_url(current_user)
  end

  def remove_friend
    @deleteFirst = Friendlist.find_by_user_id(params[:id])
    @deleteSecond = Friendlist.find_by_friend_id(params[:id])
    @deleteFirst.delete
    @deleteSecond.delete
    redirect_to user_url(current_user)
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
    redirect_to user_url(current_user)
  end

  def edit_privacy
    @privacy = ProfilePrivacy.find_by(user_id: params[:id])
  end
  
  def update_privacy
    respond_to do |format|
      if @privacy.update(privacy_params)
        format.html { redirect_to user_url(@privacy.user), notice: "Privacy updated." }
        format.json { render :show, status: :ok, location: @privacy.user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @privacy.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_privacy
      @privacy = ProfilePrivacy.find_by(user_id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def privacy_params
      params.require(:profile_privacy).permit(:email, :phone_number, :profile_photo, :friends, :groups)
    end
end
