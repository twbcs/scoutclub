class Schedule < ActiveRecord::Base
	belongs_to :doing_type
	has_many :schedule_attends
	
end