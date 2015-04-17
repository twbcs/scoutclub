class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :file
      t.string :title
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :photos, :user_id
  end
end
