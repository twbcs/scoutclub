class Groups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :admin
    end
    create_table :group_forums do |t|
      t.integer :group_id
      t.integer :forum_id
      t.integer :level, limit: 1
      t.timestamps null: false
    end
    create_table :user_groups do |t|
      t.integer :user_id
      t.integer :group_id
      t.timestamps null: false
    end
  end
end
