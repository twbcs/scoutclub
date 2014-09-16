class TitleTh < ActiveRecord::Base
	belongs_to :title
	belongs_to :member
end