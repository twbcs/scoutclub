class Album < ActiveRecord::Base
  has_many :photos
  validates_presence_of :title, on: :create, message: '不能為空'
  scope :order_by_time, -> { order(created_at: :desc) }
end
