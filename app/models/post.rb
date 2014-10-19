class Post < ActiveRecord::Base
	belongs_to :forum
	belongs_to :user
	delegate :name, to: :user, prefix: "post" 

	scope :order_by_updated_at, -> { order(updated_at: :asc) }
end
