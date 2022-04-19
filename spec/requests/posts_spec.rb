require "rails_helper"

RSpec.describe "Posts", type: :request do
  before :each do
    Ahmed = User.new(user_name: "Ahmed", email: "Ahmed@gmail.com",
                     phone_number: 8749387484, password: "123456",
                     password_confirmation: "123456")
    Ahmed.save()

    Ali = User.new(user_name: "Ali", email: "Ali@gmail.com",
                   phone_number: 8749447484, password: "123456",
                   password_confirmation: "123456")
    Ali.save()

    sign_in Ahmed
    @post_by_ahmed = Post.new(text: "This post is by Ahmed", user_id: Ahmed.id)
    @post_by_ahmed.save
    @post_by_ali = Post.new(text: "", user_id: Ali.id)
    @post_by_ali.image.attach(fixture_file_upload('avatar.png', "image/png"))
    @post_by_ali.save()
    @post = {
      "text" => "this is the best post ever"
    }
    @p = {
      "text" => ""
    }
    @empty_post = {
      "text" => "",
      "image" => "",
    }
  end
  describe "GET /index" do
    it "should response true" do
      get posts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show/:id" do
    it "should response true" do
      get posts_url(@post)
      expect(response).to be_successful
    end

    it "should response true if user is not signed in" do
      sign_out Ahmed
      get post_url(@post_by_ahmed)
      expect(response).to be_successful
    end
  end

  describe "GET /posts/new" do
    it "should response true with user signed in" do
      sign_in Ahmed
      get new_post_url
      expect(response).to be_successful
    end
    it "should not load if user is not signed in" do
      sign_out Ahmed
      get new_post_url
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe "POST /posts" do
    it "should create post with text only" do
      post posts_url, params: { post: @post }
      expect(response).to redirect_to(Post.last())
    end

    it "should fail if no user is signed in" do
      sign_out Ahmed
      post posts_url, params: { post: @post }
      expect(response).to_not be_successful
    end

    it "should create post if user uploaded an image with no text " do
      sign_out Ahmed
      sign_in Ali
      expect do
        post posts_url, params: { post: @p }
        expect(response).to be_successful
        expect(response).to redirect_to(Post.last())
      end
    end
  end

  describe "GET  /posts/1/edit" do
    it "should response true if current user is the eq post.user_id" do
      sign_in Ahmed
      get edit_post_url(@post_by_ahmed)
      expect(response).to be_successful
    end

    it "should not response true if current user is not the eq post.user_id" do
      sign_out Ahmed
      sign_in Ali
      get edit_post_url(@post_by_ahmed)
      expect(response).to_not be_successful
    end
    it "should not response true if no user is signed in" do
      sign_out Ahmed
      sign_out Ali
      get edit_post_url(@post_by_ahmed)
      expect(response).to_not be_successful
    end
  end

  describe "DELETE /posts/1" do
    it "should destroy their own post" do
      expect do
        sign_in Ahmed
        delete post_url(@post_by_ahmed)
      end.to change(Post, :count).by(-1)
    end

    it "should not destroy other users posts" do
      sign_out Ahmed
      sign_in Ali
      expect do
        delete post_url(@post_by_ahmed)
      end.to change(Post, :count).by(0)
    end
    it "should not destroy posts if they are not signed in" do
      sign_out Ahmed
      sign_out Ali
      expect do
        delete post_url(@post_by_ahmed)
      end.to change(Post, :count).by(0)
    end
  end

  describe "PATCH or PUT /posts/1" do
    it "user should be able to update their own posts" do
      sign_in Ahmed
      patch post_url(@post_by_ahmed), params: { post: @post }
      expect(Post.find(@post_by_ahmed.id).text).to eq(@post["text"])
      expect(response).to redirect_to(post_url(@post_by_ahmed))
    end

    # it "user should not be able to update their own posts to an empty string with no image" do
    #   sign_in Ahmed
    #   patch post_url(@post_by_ahmed), params: { post: @empty_post }
    #   expect(Post.find(@post_by_ahmed.id).text).to_not eq(@empty_post["text"])
    #   expect(Post.find(@post_by_ahmed.id).image).to_not eq(@empty_post["image"])
    # end

    it "user should not be able to update other users' posts" do
      sign_in Ahmed
      patch post_url(@post_by_ali), params: { post: @post }
      expect(Post.find(@post_by_ali.id).text).to eq(@post_by_ali.text)
    end
  end
end
