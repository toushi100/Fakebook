class AddStatusField < ActiveRecord::Migration[7.0]
  def change
    add_column :friendlists, :status, :boolean, default: false
  end
end
