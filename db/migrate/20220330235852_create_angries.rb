class CreateAngries < ActiveRecord::Migration[7.0]
  def change
    create_table :angries do |t|
      t.string :type
      
      t.timestamps
    end
  end
end
