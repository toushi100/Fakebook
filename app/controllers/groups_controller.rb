class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create,:join_group]
  before_action :correct_user?, only: [:destroy]

  def create
    @newGroup = Group.new
    @newGroup.name = params[:name]
    @newGroup.created_by_id = current_user.id
    @newGroup.save
    current_user.groups << @newGroup
    message = "#{current_user.user_name} created group #{@newGroup.name}"
    scope = current_user.friends
    SendNotificationsJob.perform_now({:message => message, :scope => scope})
  end

  def join_group
    current_user.groups << Group.find(params[:id])
  end

  def remove_user_from_group
    p params
    current_user.user_groups.find_by_group_id(params[:id]).delete
  end
 

  def destroy
    Group.find(params[:id]).delete
  end

  def index
    @groups = Group.all
  end
  
  def update

  end

  def new

  end


  def correct_user?
    group = Group.find_by(id: params[:id])
    redirect_to new_user_session_url, notice: "Please sign in " unless group.created_by_id == current_user
  end
end
