class SetDefault < ActiveRecord::Migration
  def change
    change_column :posts, :view_count, :integer, :default => 0, null: false
    change_column :albums, :view_count, :integer, :default => 0, null: false
  end
end
