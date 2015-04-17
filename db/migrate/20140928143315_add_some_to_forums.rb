class AddSomeToForums < ActiveRecord::Migration
  def change
    remove_column :forums, :see_level
    remove_column :forums, :create_level
    remove_column :forums, :manage_level
    remove_column :forums, :school_level
    add_column :forums, :public, :boolean, default: true
    add_column :forums, :closing_date, :date
  end
end
