class Forum < ActiveRecord::Base
	has_many :posts
	has_many :group_forums
	has_many :groups, :through => :group_forums
	belongs_to :forum_type
	delegate :title, :to => :forum_type, :prefix => true

	scope :order_by_forum_type, -> { order(forum_type_id: :asc) }
end
