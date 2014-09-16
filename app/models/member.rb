class Member < ActiveRecord::Base
	has_many :title_ths
	has_many :titles, :through => :title_ths
	
end