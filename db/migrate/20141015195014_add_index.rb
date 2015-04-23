class AddIndex < ActiveRecord::Migration
  def change
    add_index(:boards, :user_id)
    add_index(:forums, :forum_type_id)
    add_index(:group_forums, :group_id)
    add_index(:group_forums, :forum_id)
    add_index(:members, :user_id)
    add_index(:modifies, :user_id)
    add_index(:posts, :forum_id)
    add_index(:posts, :user_id)
    add_index(:schedule_attends, :user_id)
    add_index(:schedule_attends, :schedule_id)
    add_index(:schedules, :doing_type_id)
    add_index(:title_ths, :member_id)
    add_index(:title_ths, :title_id)
    add_index(:user_groups, :user_id)
    add_index(:user_groups, :group_id)
  end
end
