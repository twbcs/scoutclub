class PostAddOne < ActiveRecord::Migration
  def change
    add_column :posts, :one, :boolean
  end
end
