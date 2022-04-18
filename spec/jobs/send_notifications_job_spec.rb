require 'rails_helper'

RSpec.describe SendNotificationsJob, type: :job do
  before :each do
    Ahmed = User.create!(user_name: "Ahmed", email: "Ahmed@gmail.com", phone_number: 8749387484, password: "123456", password_confirmation: "123456")
    Ali = User.create!(user_name: "Ali", email: "Ali@gmail.com",
                       phone_number: 9038456748,
                       password: "123456", password_confirmation: "123456")
    new_friend = Friendlist.create(user_id: Ahmed.id, friend_id: Ali.id)

  end

  it "should create new notification for all users" do
    scope = []
    Ahmed.friends.each {|friend| scope.append(friend)}
    p scope
    ActiveJob::Base.queue_adapter = :test
    expect {
      SendNotificationsJob.perform_later({:message => "message", :scope => scope})
    }.to have_enqueued_job
  end
end
