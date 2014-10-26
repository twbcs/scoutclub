class Post < ActiveRecord::Base
	after_create :update_first
	belongs_to :forum
	belongs_to :user
	delegate :name, to: :user, prefix: "post"

	scope :order_by_updated_post, -> { order(update_post: :desc) }
	scope :find_first_count_reply, -> { find_by_sql("select po.*, COUNT(reply.reply_id) as reply_id
						FROM (select * from posts where reply_id IS NULL AND first_post) AS po
						left join posts as reply ON po.id = reply.reply_id GROUP BY reply.reply_id") }

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
