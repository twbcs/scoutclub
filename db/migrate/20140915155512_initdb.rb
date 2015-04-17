class Initdb < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :th
      t.string :name,  null: false
      t.string :nname
      t.string :fname
      t.boolean :sex
      t.integer :year, limit: 2, unsigned: true
      t.integer :user_id
      t.timestamps null: false
    end
    create_table :titles do |t|
      t.string :title,  null: false
      t.text :description, limit: 2000
      t.integer :level, limit: 1, unsigned: true
      t.timestamps null: false
    end
    create_table :title_ths do |t|
      t.integer :member_id,   null: false
      t.integer :title_id,    null: false
      t.integer :title_year,  null: false
      t.timestamps null: false
    end
    create_table :schedules do |t|
      t.string :title,  null: false
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :public_at
      t.string :local
      t.integer :number, limit: 2, unsigned: true
      t.integer :doing_type_id
      t.text :description, limit: 2000
      t.timestamps null: false
    end
    create_table :doing_types do |t|
      t.string :title,  null: false
      t.timestamps null: false
    end
    create_table :forum_types do |t|
      t.string :title, null: false
      t.text :description, limit: 2000
      t.timestamps null: false
    end
    create_table :forums do |t|
      t.string :title, null: false
      t.text :description, limit: 2000
      t.integer :forum_type_id
      t.integer :see_level, null: false, limit: 1, unsigned: true
      t.integer :create_level, null: false, limit: 1, unsigned: true
      t.integer :manage_level, null: false, limit: 1, unsigned: true
      t.integer :school_level, null: false, limit: 2, unsigned: true
      t.boolean :lock
      t.timestamps null: false
    end
    create_table :posts do |t|
      t.integer :forum_id, null: false
      t.string :subject, null: false
      t.text :body, null: false, limit: 2000
      t.integer :post_id
      t.integer :user_id
      t.boolean :lock
      t.timestamps null: false
    end
    create_table :boards do |t|
      t.integer :user_id
      t.string :subject
      t.text :content
      t.timestamps null: false
    end
    create_table :schedule_attends do |t|
      t.integer :user_id
      t.integer :schedule_id
      t.integer :level, limit: 1
      t.timestamps null: false
    end
  end
end
