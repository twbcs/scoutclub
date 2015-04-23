class CreateModifies < ActiveRecord::Migration
  def change
    create_table :modifies do |t|
      t.integer :user_id
      t.integer :user_rule, limit: 1
      t.timestamps null: false
    end
  end
end
