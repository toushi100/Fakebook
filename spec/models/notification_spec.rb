require 'rails_helper'

RSpec.describe Notification, type: :model do
  before :each do
    Ahmed = User.new(user_name: "Ahmed", email: "Ahmed@gmail.com", phone_number: 8749387484, password: "123456", password_confirmation: "123456")
    Ahmed.save()

    @post = Post.new()
    @post.text = "this is the text of the post"
    @post.user = Ahmed
    @post.save()
  end

  it "should create new notification for all users" do
    comment = Comment.new()
    comment.content = "this is the text of the comment"
    comment.user_id = Ahmed.id
    comment.post_id = @post.id
    
    comment.save()
    expect(comment).to be_valid
  end
end
