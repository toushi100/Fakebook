require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        name: "Name",
        description: "Description",
        online_InPerson: false,
        post_permission: false,
        invite_permission: false,
        location: "Location"
      ),
      Event.create!(
        name: "Name",
        description: "Description",
        online_InPerson: false,
        post_permission: false,
        invite_permission: false,
        location: "Location"
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: "Location".to_s, count: 2
  end
end
