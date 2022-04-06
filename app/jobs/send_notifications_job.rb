class SendNotificationsJob < ApplicationJob
  queue_as :default

  def perform(p)
    p[:scope].each {|user|
      Notification.create(user_id: user.id, Message: p[:message])
      # RemoveOldNotificationJob.perform_now(user: user)
    }
  end
end
