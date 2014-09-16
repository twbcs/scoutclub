class Schedule < ActiveRecord::Base
	belongs_to :doing_type
	has_many :schedule_attends
	has_many :users, :through => :schedule_attends

end