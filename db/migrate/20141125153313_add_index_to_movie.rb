class AddIndexToMovie < ActiveRecord::Migration
  def change
    add_index(:movies, :user_id)

  end
end
