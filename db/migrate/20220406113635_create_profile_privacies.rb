class CreateProfilePrivacies < ActiveRecord::Migration[7.0]
  def change
    create_table :profile_privacies do |t|
      t.string :email, default: "friends"
      t.string :phone_number, default: "friends"
      t.string :profile_photo, default: "friends"
      t.string :friends, default: "friends"
      t.string :groups, default: "friends"
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
