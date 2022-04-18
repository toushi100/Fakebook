class SendNotificationsJob < ApplicationJob
  queue_as :default

  def perform(p)
    p[:scope].each {|user|
      Notification.create(user_id: user.id, Message: p[:message])
      if Notification.where(user_id: user.id).count > 20
        Notification.first.destroy
      end
    }
  end
end
