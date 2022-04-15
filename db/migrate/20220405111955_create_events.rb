class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.datetime :date, default: DateTime.now
      t.string :description
      t.boolean :online_InPerson, null: false
      t.boolean :post_permission, default: true
      t.boolean :invite_permission, default: true
      t.string :location

      t.timestamps
    end
  end
end
