class CreateCampings < ActiveRecord::Migration
  def change
    create_table :campings do |t|
      t.string :name, null: false
      t.string :address
      t.string :area, null: false
      t.text :description, limit: 5000
      t.boolean :water
      t.boolean :electric
      t.boolean :canopy
      t.boolean :check
      t.boolean :expense
      t.boolean :camping_area
      t.string :url
      t.string :gmap

      t.timestamps null: false
    end
  end
end
