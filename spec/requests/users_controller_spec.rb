require "rails_helper"

RSpec.describe "UsersControllers", type: :request do
  before do
    @file = fixture_file_upload("/home/ahmed/Desktop/i.png", "")
    Ahmed = User.create!(user_name: "Ahmed", email: "Ahmed@gmail.com",
                         phone_number: 9033453648, profile_picture: @file,
                         password: "123456", password_confirmation: "123456")
    Ali = User.create!(user_name: "Ali", email: "Ali@gmail.com",
                       phone_number: 9038456748, profile_picture: @file,
                       password: "123456", password_confirmation: "123456")
    sign_in Ahmed
    post send_friend_request_url(Ali)
    sign_out Ahmed
    sign_in Ali
    post accept_friend_request_url
  end

  describe "GET /show" do
    it "renders a successfull response for show user (profile)" do
      user = User.first_or_create!(user_name: "shrex", email: "sherx@email.com",
                                   phone_number: "8374848887", password: "password", password_confirmation: "password",
                                   profile_picture: fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png"))
      get user_url(user)
      expect(response).to be_successful
    end
  end
end
