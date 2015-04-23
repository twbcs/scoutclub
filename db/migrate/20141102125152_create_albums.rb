class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.text :description
      t.integer :view_count
      t.datetime :public_at
      t.datetime :add_photo_to

      t.timestamps null: false
    end
  end
end
