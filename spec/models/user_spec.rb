require "rails_helper"

RSpec.describe User, type: :model do
  filename_path = 'app/assets/images/avatar.png'
  content_type = 'image/png'
  it "should create new user" do
    user = User.new()
    user.user_name = "shrex"
    user.email = "shrex@email.com"
    user.phone_number = 8373892999
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "password"
    user.password_confirmation = "password"
    user.save()

    expect(user).to be_valid
  end

  it "should not create new user with empty user_name" do
    user = User.new()
    user.user_name = ""
    user.email = "shrex@email.com"
    user.phone_number = 8373999892
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "password"
    user.password_confirmation = "password"
    user.save()

    expect(user).to_not be_valid
  end

  it "should not create new user with user_name using numbers" do
    user = User.new()
    user.user_name = "444444"
    user.email = "shrex@email.com"
    user.phone_number = 8373892888
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "password"
    user.password_confirmation = "password"
    user.save()

    expect(user).to_not be_valid
  end

  it "should create new user with user_name with 3 letters" do
    user = User.new()
    user.user_name = "Ali"
    user.email = "shrex@email.com"
    user.phone_number = 8373892888
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "password"
    user.password_confirmation = "password"
    user.save()

    expect(user).to be_valid
  end

  it "should not create new user with user_name with numbers and letters" do
    user = User.new()
    user.user_name = "Ali6666s"
    user.email = "shrex@email.com"
    user.phone_number = 8355573892
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "password"
    user.password_confirmation = "password"
    user.save()

    expect(user).to_not be_valid
  end

  it "should not create new user with user_name with whitespace only" do
    user = User.new()
    user.user_name = "               "
    user.email = "shrex@email.com"
    user.phone_number = 8373892888
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "password"
    user.password_confirmation = "password"
    user.save()

    expect(user).to_not be_valid
  end

  it "should not create new user with user_name with special characters only" do
    user = User.new()
    user.user_name = "@#$%^&*&(*("
    user.email = "shrex@email.com"
    user.phone_number = 8373892888
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "password"
    user.password_confirmation = "password"
    user.save()

    expect(user).to_not be_valid
  end

  it "should not create new user with user_name with special characters and letters" do
    user = User.new()
    user.user_name = "Ahmed&&^"
    user.email = "shrex@email.com"
    user.phone_number = 8373892888
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "password"
    user.password_confirmation = "password"
    user.save()

    expect(user).to_not be_valid
  end
  it "should not create a user with empty email" do
    user = User.new()
    user.user_name = "Ahmed"
    user.email = ""
    user.phone_number = 8373892666
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "password"
    user.password_confirmation = "password"
    user.save()

    expect(user).to_not be_valid
  end

  it "should not create a user with invalid email format" do
    user = User.new()
    user.user_name = "Ahmed"
    user.email = "Ahmedgamil.com"
    user.phone_number = 8373892666
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "password"
    user.password_confirmation = "password"
    user.save()

    expect(user).to_not be_valid
  end
  # This is handled in the validations and not the model
  # it "should not create a user without domain name for email" do
  #   user = User.new()
  #   user.user_name = "Ahmed"
  #   user.email = "Ahmed@gamil."
  #   user.phone_number = 8373892666
  #   user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
  #   user.password = "password"
  #   user.password_confirmation = "password"
  #   user.save()

  #   expect(user).to_not be_valid
  # end

  it "should not create a user with empty phone number" do
    user = User.new()
    user.user_name = "Ahmed"
    user.email = "Ahmed@gamil.com"
    user.phone_number =
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "password"
    user.password_confirmation = "password"
    user.save()

    expect(user).to_not be_valid
  end

  it "should create a user with international phone number" do
    user = User.new()
    user.user_name = "Ahmed"
    user.email = "Ahmed@gamil.com"
    user.phone_number = 201055599433
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "password"
    user.password_confirmation = "password"
    user.save()

    expect(user).to be_valid
  end

  it "should create a user without uploading an image" do
    user = User.new()
    user.user_name = "Ahmed"
    user.email = "Ahmed@gamil.com"
    user.phone_number = 5599433
    user.profile_picture = fixture_file_upload(filename_path,content_type)
    user.password = "password"
    user.password_confirmation = "password"
    user.save()

    expect(user).to_not be_valid
  end

  #invalid test case this is handled in the form and the controller and not the model
  # it "should not create a user with other file types" do
  #   user = User.new()
  #   user.user_name = "Ahmed"
  #   user.email = "Ahmed@gamil.com"
  #   user.phone_number = 1055599433
  #   user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/pdf.pdf", "file/pdf")
  #   user.password = "password"
  #   user.password_confirmation = "password"
  #   user.save()

  #   expect(user).to_not be_valid
  # end

  it "should not create a user without password" do
    user = User.new()
    user.user_name = "Ahmed"
    user.email = "Ahmed@gamil.com"
    user.phone_number = 5599433
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = ""
    user.password_confirmation = ""
    user.save()

    expect(user).to_not be_valid
  end

  it "should create a user with password special characters only" do
    user = User.new()
    user.user_name = "Ahmed"
    user.email = "Ahmed@gamil.com"
    user.phone_number = 5593339433
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "()*&(*&(*&"
    user.password_confirmation = "()*&(*&(*&"
    user.save()

    expect(user).to be_valid
  end

  it "should not create a user with password mismatch" do
    user = User.new()
    user.user_name = "Ahmed"
    user.email = "Ahmed@gamil.com"
    user.phone_number = 5599433
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "()*&(*&*&"
    user.password_confirmation = "()*&(*&(*&"
    user.save()

    expect(user).to_not be_valid
  end

  it "should create a user with password numbers only" do
    user = User.new()
    user.user_name = "Ahmed"
    user.email = "Ahmed@gamil.com"
    user.phone_number = 5599433333
    user.profile_picture = fixture_file_upload("/home/ahmed/Desktop/default.png", "image/png")
    user.password = "123456"
    user.password_confirmation = "123456"
    user.save()

    expect(user).to be_valid
  end
end
