require "rails_helper"

RSpec.describe "Groups", type: :request do
  before do
    Ahmed = User.new(user_name: "ahmed", email: "Ahmed@gmail.com",
                     phone_number: 7263748474, password: "12341234", password_confirmation: "12341234")
    Ahmed.profile_picture.attach(io: File.open("/home/ahmed/Desktop/default.png"),
                                 filename: "default.png")
    Ali = Ahmed.dup
    Ahmed.save
    Ali.email = "Ali@gmail;.com"
    Ali.phone_number = 3727384743
    Ali.save
  end
  describe "POST  /groups/index" do
    it "should create a group with user signed in" do
      sign_in Ahmed
      post groups_index, params: { name: "the group" }
      expect(respone).to be_successful
    end
  end
end
