require 'rails_helper'

RSpec.describe "Angries", type: :request do
  before do
    @file = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    Ahmed = User.create!(user_name: "Ahmed", email: "Ahmed@g.com",
                         phone_number: 19170373200, profile_picture: @file,
                         password: "12341234", password_confirmation: "12341234")
    @post_image = fixture_file_upload("/home/ahmed/Desktop/i.png",
                                      "image/png")
    p Ahmed
    sign_in Ahmed
  end
  describe "POST /angries" do
    it "should add an angry react" do
      post = Post.create!(text: "post text", user_id: Ahmed.id)
      post angries_url(post)
      expect(response).to redirect_to(post_url(post))
    end
  end
end
