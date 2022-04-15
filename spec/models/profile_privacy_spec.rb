require 'rails_helper'

RSpec.describe ProfilePrivacy, type: :model do
  it "should create profile privacies with default audience" do
    @user = User.new(user_name: "Ahmed", email: "ahmed@gmail.com",
                     phone_number: 8749387484, password: "123456",
                     password_confirmation: "123456")
    @user.save()
    privacies = @user.privacy
    expect(privacies.email).to eq("friends")
    expect(privacies.phone_number).to eq("friends")
    expect(privacies.profile_photo).to eq("friends")
    expect(privacies.friends).to eq("friends")
    expect(privacies.groups).to eq("friends")
  end
end
