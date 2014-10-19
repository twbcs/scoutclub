class Schedule < ActiveRecord::Base
	belongs_to :doing_type
	delegate :title, to: :doing_type, prefix: "type" 
	has_many :schedule_attends
	has_many :users, :through => :schedule_attends

	validates :title, presence: true

	scope :order_by_time, -> { order(start_date: :asc) }

end
