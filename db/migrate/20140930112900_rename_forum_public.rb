class RenameForumPublic < ActiveRecord::Migration
  def change
    rename_column :forums, :public, :public_at
  end
end
