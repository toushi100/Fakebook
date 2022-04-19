class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :Message
      t.string :Link
      t.boolean :Viewed, default: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
