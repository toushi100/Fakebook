require "rails_helper"

RSpec.describe "Groups", type: :request do
  before :each do
    Ahmed = User.new(user_name: "Ahmed", email: "Ahmed@gmail.com",
                     phone_number: 8749387484, password: "123456",
                     password_confirmation: "123456")
    Ahmed.save()
    @group = Group.new(name: "name", created_by_id: 1)
    @group.save()
  end
  describe "POST  /groups/index" do
    it "should create a group with user signed in" do
      sign_in Ahmed
      post groups_create_url, params: { name: "the group" }
      expect(response).to be_successful
      expect(Group.last.name).to eq("the group")
      expect(Group.last.created_by_id).to eq(Ahmed.id)
    end

    it "should not create a group with user signed out" do
      post groups_create_url, params: { name: "the group" }
      expect(response).to redirect_to(new_user_session_url)
    end
  end
  describe "POST   /groups/add_user_to_group/:id" do
    it "should join current user to group" do
      sign_in Ahmed
      @group = Group.new(name: "name", created_by_id: 1)
      @group.save()
      post join_group_url(@group)
      expect(response).to be_successful
    end
  end
  describe " DELETE /groups/remove_user_from_group/:id" do
    it "should delete group by admin" do
      sign_in Ahmed
      post groups_create_url, params: { name: "the group" }
      @group = Group.last
      expect do
      delete remove_user_from_group_url(@group.id)
      end.to change(UserGroup,:count).by(-1)
    end
  end
end
