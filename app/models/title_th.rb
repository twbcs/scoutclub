class TitleTh < ActiveRecord::Base
	belongs_to :title
	belongs_to :member
	accepts_nested_attributes_for :title
end