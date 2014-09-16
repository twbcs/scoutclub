class Forum < ActiveRecord::Base
	has_many :posts
	belongs_to :forum_type
end