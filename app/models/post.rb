class Post < ActiveRecord::Base
	after_create :update_first
	belongs_to :forum
	belongs_to :user
	delegate :name, to: :user, prefix: "post"

	scope :order_by_updated_at, -> { order(updated_at: :desc) }

	private
	def update_first
	 	if self.reply_id
			first_post = Post.find_by(id: self.reply_id)
			first_post.update_column(:updated_at, Time.now)
		end
	end
end
