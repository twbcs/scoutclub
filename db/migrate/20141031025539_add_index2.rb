class AddIndex2 < ActiveRecord::Migration
  def change
    add_index(:articles, :user_id)
    add_index(:articles, :art_type_id)
    add_index(:comments, :user_id)
    add_index(:comments, :article_id)
  end
end
