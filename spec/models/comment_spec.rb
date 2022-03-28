require 'rails_helper'

RSpec.describe Comment, type: :model do
    before :each do
        @file = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
        Ahmed = User.new(user_name: "Ahmed", email: "Ahmed@gmail.com", phone_number: 8749387484, password: "123456", password_confirmation: "123456")
        Ahmed.profile_picture = @file
        Ahmed.save()
        @post = Post.new(text:"this is the post",user_id: Ahmed.id)
        @post.save()
      end

      it "should create new comment" do
        comment = Comment.new()
        comment.content = "this is the text of the comment"
        comment.post_id = @post.id
        comment.user_id = Ahmed.id
        comment.save()
        expect(comment).to be_valid
      end

      it "should not create new comment with empty text" do
        comment = Comment.new()
        comment.content = ""
        comment.post_id = @post.id
        comment.user_id = Ahmed.id
        comment.save()
        expect(comment).to_not be_valid
      end

      it "should not create new comment without user id" do
        comment = Comment.new()
        comment.content = "this is the text of the comment"
        comment.post_id = @post.id
        comment.save()
        expect(comment).to_not be_valid
      end

      it "should not create new comment without post id" do
        comment = Comment.new()
        comment.content = "this is the text of the comment"
        comment.user_id = Ahmed.id
        comment.save()
        expect(comment).to_not be_valid
      end
end
