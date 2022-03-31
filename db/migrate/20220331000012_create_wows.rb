class CreateWows < ActiveRecord::Migration[7.0]
  def change
    create_table :wows do |t|
      t.string :type
      
      t.timestamps
    end
  end
end
