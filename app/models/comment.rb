class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # def current_user?(user)
  #   user == current_user
  # end

  # def current_user
  #   if(user_id = session[:user_id])
  #     @current_user ||= User.find_by(id: user_id)
  #   end
  # end

  # def correct_user
  #   @comment = Comment.find_by(id: params[:id])
  #   unless current_user?(@comment.user)
  #       redirect_to request.referrer
  #   end
  # end
end
