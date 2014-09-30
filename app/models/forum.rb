class Forum < ActiveRecord::Base
	has_many :posts
	belongs_to :forum_type
	has_many :group_forums
	has_many :groups, :through => :group_forums

	scope :order_by_forum_type, -> { order(forum_type_id: :asc) }
end
