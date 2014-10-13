class AddTypeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :type, :string
    change_column :posts, :lock, :datetime
    rename_column :posts, :lock, :lock_at
  end
end
