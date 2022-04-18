class AddPrivacyToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :privacy, :string, default: "friends"
  end
end
