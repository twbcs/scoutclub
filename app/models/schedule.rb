class Schedule < ActiveRecord::Base
	belongs_to :doing_kind
	delegate :title, to: :doing_kind, prefix: "kind"
	has_many :schedule_attends
	has_many :users, :through => :schedule_attends

	validates_presence_of :title, :on => :create, :message => "不能為空"
	validates :doing_kind_id, presence: true

	scope :order_by_time, -> { order(start_date: :desc) }
end
