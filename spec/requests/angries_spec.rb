require 'rails_helper'

RSpec.describe "Angries", type: :request do
  before :each do
    @user = User.new(user_name: "Ahmed", email: "Ahmed@gmail.com", phone_number: 8749387484, password: "123456", password_confirmation: "123456")
    @user.save()

    sign_in @user
  end

  describe "POST /angries" do
    it "should add an angry react" do
      
      post = Post.create!(text: "post text", user_id: @user.id)
      post add_angry_url(post)
      expect(response).to redirect_to(post_url(post))
    end
  end
end
