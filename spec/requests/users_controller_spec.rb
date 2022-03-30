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
  end
  describe "GET /show" do
    it "renders a successful response for show user (profile)" do
      get user_url(Ahmed)
      expect(response).to be_successful
    end

    it "renders a failed response for show user if wrong user" do
      get user_url()
      expect(response).to_not be_successful
    end
  end
  describe "GET /index" do
    it "renders a successful response when user is not signed in" do
      get users_index_url
      expect(response).to be_successful
    end

    it "renders a successful response when user is signed in" do
      sign_in Ahmed
      get users_index_url
      expect(response).to be_successful
    end
  end

end
