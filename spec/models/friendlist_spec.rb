require "rails_helper"

RSpec.describe Friendlist, type: :model do
  before do
    @file = fixture_file_upload("/home/ahmed/Desktop/i.png", "")
    Ahmed = User.create!(user_name: "Ahmed", email: "Ahmed@gmail.com",
                         phone_number: 9033453648, profile_picture: @file,
                         password: "123456", password_confirmation: "123456")
    Ali = User.create!(user_name: "Ali", email: "Ali@gmail.com",
                       phone_number: 9038456748, profile_picture: @file,
                       password: "123456", password_confirmation: "123456")
  end
  it "should have send friend request" do
    new_friend_before_accept = Friendlist.create(user_id: Ahmed.id, friend_id: Ali.id)
    expect(new_friend_before_accept).to be_valid
  end

  it "should not have send friend request if friend is missing" do
    new_friend_before_accept = Friendlist.create(user_id: Ahmed.id, friend_id: "")
    expect(new_friend_before_accept).to_not be_valid
  end
  it "should not have send friend request if user is missing" do
    new_friend_before_accept = Friendlist.create(user_id: '', friend_id: Ali.id)
    expect(new_friend_before_accept).to_not be_valid
  end
  
  it "should be a friend" do
    new_friend_before_accept = Friendlist.create(user_id: Ahmed.id, friend_id: Ali.id)
    new_friend_before_accept.update(status:true)
    new_friend_after_accept = Friendlist.create(user_id: Ali.id, friend_id: Ahmed.id,status:true)
    expect(new_friend_before_accept).to be_valid
    expect(new_friend_after_accept).to be_valid
    expect(new_friend_after_accept.status).to eq(true)
    expect(new_friend_after_accept.status).to eq(true)
  end

  # it "should not be valid if status is false before creating the inverted record" do
  #   new_friend_before_accept = Friendlist.create(user_id: Ahmed.id, friend_id: Ali.id)
  #   new_friend_before_accept.update(status:false)
  #   new_friend_after_accept = Friendlist.create(user_id: Ali.id, friend_id: Ahmed.id,status:true)
  #   expect(new_friend_before_accept).to be_valid
  #   expect(new_friend_after_accept).to_not be_valid
  #   expect(new_friend_before_accept.status).to eq(false)
  #   expect(new_friend_after_accept.status).to eq(false)
  # end
end
