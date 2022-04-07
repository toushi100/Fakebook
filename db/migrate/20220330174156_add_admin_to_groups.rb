class AddAdminToGroups < ActiveRecord::Migration[7.0]
  def change
    add_reference  :groups, :created_by, index: true
  end
end
