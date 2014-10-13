class AddCountToPost < ActiveRecord::Migration
  def change
    add_column  :posts, :view_count, :integer
    rename_column :posts, :post_id, :reply_id
  end
end
