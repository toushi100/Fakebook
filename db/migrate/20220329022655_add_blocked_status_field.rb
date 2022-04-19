class AddBlockedStatusField < ActiveRecord::Migration[7.0]
  def change
    add_column :block_lists, :blocked_status, :boolean, default: false
  end
end
