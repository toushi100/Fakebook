class CreateLoves < ActiveRecord::Migration[7.0]
  def change
    create_table :loves do |t|
      t.string :type
      
      t.timestamps
    end
  end
end
