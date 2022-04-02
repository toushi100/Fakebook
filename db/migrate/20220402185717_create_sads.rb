class CreateSads < ActiveRecord::Migration[7.0]
  def change
    create_table :sads do |t|
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :sads, [:user_id, :post_id], unique: true
  end
end
