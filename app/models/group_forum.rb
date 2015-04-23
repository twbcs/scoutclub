class GroupForum < ActiveRecord::Base
  belongs_to :group
  belongs_to :forum

end
