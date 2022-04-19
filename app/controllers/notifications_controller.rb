class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(user_id: params[:user_id])
    @not_viewed = Notification.where(user_id: params[:user_id], viewed: false)
    @not_viewed.each{
      |notification| 
      notification.Viewed = true
      notification.save
    }
  end

end
