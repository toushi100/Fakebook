require 'rails_helper'

RSpec.describe Event, type: :model do
  before :each do
    @user = User.new(user_name: "Ahmed", email: "Ahmed@gmail.com", phone_number: 8749387484, password: "123456", password_confirmation: "123456")
    @user.save()
  end

  it "should create new event" do
    event = Event.new(name: "new event", online_InPerson: true, user_id: @user.id)
    event.save()
    expect(event).to be_valid
  end

  it "should not create new event with no user" do
    event = Event.new(name: "new event", online_InPerson: true)
    event.save()
    expect(event).to_not be_valid
  end

  it "should not create new event without name" do
    event = Event.new(online_InPerson: true)
    event.save()
    expect(event).to_not be_valid
  end
end
