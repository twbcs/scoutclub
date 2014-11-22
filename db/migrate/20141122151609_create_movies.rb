class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :url
      t.integer :user_id
      t.boolean :public_is
      t.text    :description

      t.timestamps
    end
  end
end
