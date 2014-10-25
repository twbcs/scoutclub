class PostAddUpdatePost < ActiveRecord::Migration
  def change
    add_column :posts, :update_post, :datetime
  end
end
