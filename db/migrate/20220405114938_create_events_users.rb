class CreateEventsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :events_users, id: false do |t|
      t.belongs_to :event
      t.belongs_to :user

      t.timestamps
    end
  end
end
