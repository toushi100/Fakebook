class RemoveAudiences < ActiveRecord::Migration[7.0]
  def change
    drop_table "audiences" do |t|
      t.string "name"
      
    end
  end
end
