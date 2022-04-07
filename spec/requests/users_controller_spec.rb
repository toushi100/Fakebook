require "rails_helper"

RSpec.describe "UsersControllers", type: :request do
  context do
    @file = fixture_file_upload("/home/ahmed/Desktop/i.png", "")
    Ahmed = User.create!(user_name: "Ahmed", email: "Ahmed@gmail.com",
                         phone_number: 9033453648, profile_picture: @file,
                         password: "123456", password_confirmation: "123456")
    Ali = User.create!(user_name: "Ali", email: "Ali@gmail.com",
                       phone_number: 9038456748, profile_picture: @file,
                       password: "123456", password_confirmation: "123456")
    sign_in Ahmed
  end
  describe "GET /show" do
    it "renders a successful response for show user (profile)" do
      get user_url(Ahmed)
      expect(response).to be_successful
    end
  end
  describe "GET /index" do
    it "renders a successful response when user is not signed in" do
      sign_out Ahmed 
      sign_out Ali
      get users_index_url
      expect(response).to redirect_to new_user_session_url
    end

    it "renders a successful response when user is signed in" do
      sign_in Ahmed
      get users_index_url
      expect(response).to be_successful
    end
  end
  describe "POST users/send_friend_request/:id" do
    it "renders a successful response when user is signed in" do
      sign_in Ahmed
      expect do
        post send_friend_request_url(Ali), params: { "id" => Ali.id }
      end.to change(Friendlist, :count).by(1)
    end

    it "renders a redirect to sign in response when user is not signed in" do
      sign_out Ahmed 
      sign_out Ali
      post send_friend_request_url(Ali), params: { "id" => Ali.id }
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe "DELETE users/remove_friend_request/:id" do
    it "renders successful " do
      sign_in Ahmed
      post send_friend_request_url(Ali), params: { "id" => Ali.id }
      sign_in Ali
      post accept_friend_request_url
      expect do
        delete remove_friend_request_url(Ahmed), params: { "id" => Ali.id }
      end.to change(Friendlist, :count).by(-1)
    end
#functionality not yet added (user cannot remove sent request)
    # it "redirects user to sign in page if user is not signed in " do
    #   sign_out Ahmed
    #   sign_out Ali
    #     delete remove_friend_request_url(Ali), params: { "id" => Ali.id }
    #   espect(response).to redirect_to(new_user_session_url)
    # end

    # it "friend should be able to remove friend request " do
    #   sign_in Ali
    #   post send_friend_request_url(Ahmed), params: { "id" => Ali.id }
    #   expect do
    #     delete remove_friend_request_url(Ali), params: { "id" => Ali.id }
    #   end.to change(Friendlist, :count).by(-1)
    # end
  end

  describe "remove_friend DELETE /users/remove_friend/:id" do
    it "renders successful " do
      sign_in Ahmed
      post send_friend_request_url(Ali), params: { "id" => Ali.id }
      sign_in Ali
      post accept_friend_request_url
      expect do
        delete remove_friend_url(Ali), params: { "id" => Ali.id }
      end.to change(Friendlist, :count).by(-2)
    end
  end

  describe "POST   /users/block_friend/:id" do
      it "should block friend successfully " do
        sign_in Ahmed
        post send_friend_request_url(Ali)
        sign_out Ahmed
        sign_in Ali
        post accept_friend_request_url
        post block_friend_url(Ahmed)
        expect(response).to redirect_to user_url(Ali)
    end
  end

  describe "DELETE /users/un_block_friend/:id" do
    it "should UN-block friend successfully " do
      sign_in Ahmed
      post send_friend_request_url(Ali)
      sign_out Ahmed
      sign_in Ali
      post accept_friend_request_url
      post block_friend_url(Ahmed)
      delete un_block_friend_url(Ahmed)
      expect(response).to redirect_to user_url(Ali)
  end
end
end
