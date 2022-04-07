class CreateUserGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :user_groups do |t|
      t.belongs_to :user
      t.belongs_to :group
      t.timestamps
    end
  end
end
