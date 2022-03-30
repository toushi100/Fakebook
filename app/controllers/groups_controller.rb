class GroupsController < ApplicationController
  def create
    @newGroup = Group.new
    @newGroup.name = params[:name]
    @newGroup.created_by_id = current_user.id
    @newGroup.save
    
    current_user.groups << @newGroup

    redirect_to request.referrer
  end

  def add_user_to_group
    current_user.groups << Group.find(params[:id])
    redirect_to request.referrer 
  end

  def remove_user_from_group
    current_user.user_groups.find_by_group_id(params[:id]).delete
    redirect_to request.referrer 
  end

  def delete
    Group.find(params[:id]).delete
    redirect_to request.referrer 
  end

  def edit

  end

  def index
    @groups = Group.all
  end
  
  def update

  end

  def new

  end

end
