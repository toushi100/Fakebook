class RemoveColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :user_id
    remove_column :users, :index_users_on_user_id
  end
end
