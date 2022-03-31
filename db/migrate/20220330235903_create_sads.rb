class CreateSads < ActiveRecord::Migration[7.0]
  def change
    create_table :sads do |t|
      t.string :type
      
      t.timestamps
    end
  end
end
