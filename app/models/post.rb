class Post < ActiveRecord::Base
	after_create :update_first
	belongs_to :forum
	belongs_to :user
	delegate :name, to: :user, prefix: "post"

	scope :order_by_updated_post, -> { order(update_post: :desc) }

	private
	def update_first
	 	if self.reply_id
			other_post = Post.find_by(first_post: true, forum_id: self.forum_id)
			other_post.update_column(:first_post, false)
			first_post = Post.find_by(id: self.reply_id)
			first_post.update_columns(update_post: Time.now, first_post: true)
		else
			other_post = Post.find_by(first_post: true, forum_id: self.forum_id)
			other_post.update_column(:first_post, false) if other_post
			self.update_columns(update_post: Time.now, first_post: true)
		end
	end
end
