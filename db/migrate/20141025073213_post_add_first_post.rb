class PostAddFirstPost < ActiveRecord::Migration
  def change
    add_column :posts, :first_post, :boolean
  end
end
