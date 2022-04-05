require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      name: "MyString",
      description: "MyString",
      online_InPerson: false,
      post_permission: false,
      invite_permission: false,
      location: "MyString"
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input[name=?]", "event[name]"

      assert_select "input[name=?]", "event[description]"

      assert_select "input[name=?]", "event[online_InPerson]"

      assert_select "input[name=?]", "event[post_permission]"

      assert_select "input[name=?]", "event[invite_permission]"

      assert_select "input[name=?]", "event[location]"
    end
  end
end
