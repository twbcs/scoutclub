class GroupForum < ActiveRecord::Base
  belongs_to :group
  belongs_to :forum

  scope :find_set, -> { where(group_id: params[:group_id]).select(:id, :forum_id).inject({})   }
end
