class Album < ActiveRecord::Base
  has_many :photos

  scope :order_by_time, -> { order(created_at: :desc) }

end
