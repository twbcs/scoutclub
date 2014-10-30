class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text   :content
      t.integer :user_id
      t.integer :art_type_id
      t.timestamps
    end
  end
end
