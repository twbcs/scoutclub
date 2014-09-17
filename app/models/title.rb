class Title < ActiveRecord::Base
	has_many :title_ths
	has_many :members, :through => :title_ths
	
	scope :order_by_level, -> { order(level: :asc) }
end