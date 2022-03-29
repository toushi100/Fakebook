require "rails_helper"
require "spec_helper"

RSpec.describe Post, type: :model do
  before :each do
    @file = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    Ahmed = User.new(user_name: "Ahmed", email: "Ahmed@gmail.com", phone_number: 8749387484, password: "123456", password_confirmation: "123456")
    Ahmed.profile_picture = @file
    Ahmed.save()
  end

  it "should create new Post" do
    post = Post.new()
    post.text = "this is the text of the post"
    post.user_id = Ahmed.id
    post.image = @file
    post.save()
    expect(post).to be_valid
  end

  it "should create new Post without image" do
    post = Post.new()
    post.text = "this is the text of the post"
    post.user_id = Ahmed.id
    post.save()
    expect(post).to be_valid
  end

  it "should create new post with empty text field and image upload" do
    post = Post.new()
    post.text = ""
    post.user_id = Ahmed.id
    post.image = @file
    post.save()
    expect(post).to be_valid
  end

  it "should not create new post with empty text field and empty image upload" do
    post = Post.new()
    post.text = ""
    post.user_id = Ahmed.id
    post.image = @file
    post.save()
    expect(post).to_not be_valid
  end
    it "should not create new post without a signed user" do
      post = Post.new()
      post.text = "this is the text of the post"
      post.save()
      expect(post).to_not be_valid
   end
end
