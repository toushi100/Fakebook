class AddBlockedFriendIdField < ActiveRecord::Migration[7.0]
  def change
    add_reference :block_lists, :blocked_friend, references: :users, foreign_key: {to_table: :users}
  end
end
