class CreateReacts < ActiveRecord::Migration[7.0]
  def change
    create_table :reacts do |t|
      t.string :type
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true

      t.timestamps
    end

    add_index :reacts, [:user_id, :post_id, :comment_id], unique: true
  end
end
