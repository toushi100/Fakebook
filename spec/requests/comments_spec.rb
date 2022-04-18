require "rails_helper"

RSpec.describe "Comments", type: :request do
  before :each do
    @file = fixture_file_upload("avatar.png",  "image/png")
    Ahmed = User.new(user_name: "Ahmed", email: "Ahmed@gmail.com",
                     phone_number: 8749387484, password: "123456",
                     password_confirmation: "123456")
    Ahmed.profile_picture = @file
    Ahmed.save()

    Ali = User.new(user_name: "Ali", email: "Ali@gmail.com",
                   phone_number: 8749447484, password: "123456",
                   password_confirmation: "123456")
    Ali.save()
    sign_in Ahmed
    @comment = { "content" => "this comment changed to this" }
    @empty_comment = { content: "" }
    @post_by_ahmed = Post.new(text: "This post is by Ahmed", user_id: Ahmed.id)
    @post_by_ahmed.save()
    @comment_by_ahmed = Comment.new(content: "This comment is by Ahmed", user_id: Ahmed.id, post_id: @post_by_ahmed.id)
    @comment_by_ahmed.save
    @comment_by_ali = Comment.new(content: "This comment is by Ali", user_id: Ali.id, post_id: @post_by_ahmed.id)
    @comment_by_ali.save
  end

  describe "POST /posts/:id/comments" do
    it "should create a comment" do
      sign_in Ahmed
      post post_comments_url(@post_by_ahmed), params: { comment: @comment }
      expect(response).to redirect_to(post_url(@post_by_ahmed))
      expect(Comment.last().content).to eq(@comment["content"])
    end

    it "should not create a comment if user is not signed in" do
      sign_out Ahmed
      post post_comments_url(@post_by_ahmed), params: { comment: @comment }
      expect(response).to redirect_to(new_user_session_url)
    end

    it "should create a comment on other users\' posts " do
      sign_in Ali
      post post_comments_url(@post_by_ahmed), params: { comment: @comment }
      expect(response).to redirect_to(post_url(@post_by_ahmed))
      expect(Comment.last().content).to eq(@comment["content"])
      expect(Comment.last().user_id).to eq(Ali.id)
    end
  end

  describe "DELETE /posts/:id/comments/:id" do
    it "user should delete their own comments" do
      sign_in Ahmed
      expect do
        delete destroy_comment_path(@comment_by_ahmed)
      end.to change(Comment, :count).by(-1)
    end

    it "user should not be able to delete other users\' comments" do
      sign_out Ahmed
      sign_in Ali
      expect do
        delete destroy_comment_path(@comment_by_ahmed)
      end.to change(Comment, :count).by(0)
      expect(response).to redirect_to(post_url(@post_by_ahmed))
    end
    it "user should sign delete their own comments" do
      sign_out Ahmed
      sign_out Ali
      expect do
        delete destroy_comment_path(@comment_by_ahmed)
      end.to change(Comment, :count).by(0)
    end
  end
end
