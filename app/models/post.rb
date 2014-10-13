class Post < ActiveRecord::Base
	belongs_to :forum

	scope :order_by_updated_at, -> { order(updated_at: :asc) }
end
