class GroupsController < ApplicationController
  def create
    @newGroup = Group.new
    @newGroup.name = params[:name]
    @newGroup.save


    redirect_to request.referrer
  end

  def add_user_to_group
    current_user.groups << Group.find(params[:id])
    redirect_to request.referrer 
  end

  def edit

  end

  def index

  end
  
  def update

  end

  def new

  end

end
