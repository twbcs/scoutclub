class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :file
      t.string :title
      t.text :description
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :musics, :user_id
  end
end
