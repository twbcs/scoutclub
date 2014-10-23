class Post < ActiveRecord::Base
	after_create :update_first
	belongs_to :forum
	belongs_to :user
	delegate :name, to: :user, prefix: "post"

	scope :order_by_updated_at, -> { order(updated_at: :desc) }

	private
	def update_first
	 	if self.reply_id
			other_post = Post.find_by(forum_id: self.forum_id, one: true)
			other_post.update_column(:one, false)
			first_post = Post.find_by(id: self.reply_id)
			first_post.update_columns(updated_at: Time.now, one: true)
		else
			other_post = Post.find_by(forum_id: self.forum_id, one: true)
			other_post.update_column(:one, false) if other_post
			self.update_column(:one, true)
		end
	end
end
