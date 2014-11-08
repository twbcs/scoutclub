class ChangeAllTypeToOtherName < ActiveRecord::Migration
  def change
    rename_table :art_types, :art_kinds
    remove_column :art_kinds, :created_at
    remove_column :art_kinds, :updated_at
    rename_table :doing_types, :doing_kinds
    remove_column :doing_kinds, :created_at
    remove_column :doing_kinds, :updated_at
    rename_table :forum_types, :forum_kinds
    remove_column :forum_kinds, :created_at
    remove_column :forum_kinds, :updated_at
    rename_column :articles, :art_type_id, :art_kind_id
    rename_column :schedules, :doing_type_id, :doing_kind_id
    rename_column :forums, :forum_type_id, :forum_kind_id

    change_column :albums, :description, :text, limit: 2000
    change_column :albums, :title, :string, null: false
    change_column :articles, :content, :text, limit: 30000, null: false
    change_column :articles, :title, :string, null: false
    change_column :boards, :content, :text, limit: 2000, null: false
    change_column :forum_kinds, :description, :text, limit: 500
    change_column :forums, :description, :text, limit: 500
    change_column :musics, :description, :text, limit: 10000
    change_column :posts, :body, :text, limit: 15000, null: false
    change_column :schedules, :description, :text, limit: 15000, null: false
    change_column :titles, :description, :text, limit: 30000
    change_column :comments, :content, :text, limit: 2000, null: false
    change_column :groups, :name, :string, null: false
  end
end
