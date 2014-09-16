class Title < ActiveRecord::Base
	has_many :title_ths
	has_many :members, :through => :title_ths
	
end