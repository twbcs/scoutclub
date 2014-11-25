class Post < ActiveRecord::Base
	include Right
	after_create :update_first
	belongs_to :forum
	belongs_to :user
	delegate :name, :uid, :created_at, :last_sign_in_at, to: :user, prefix: "user"

	validates_presence_of :subject, :on => :create, :message => "不可為空"
	validates_presence_of :body, :on => :create, :message => "不可為空"
	scope :order_by_update_post, -> { order(update_post: :desc) }
	scope :find_first_post, -> { where(first_post: true, reply_id: nil) }
	scope :find_reply_count, -> { find_by_sql("select po.id, po.forum_id, count(rep.reply_id)
		 		as reply_id FROM (select * from posts where reply_id IS NULL AND first_post)
				 AS po join posts as rep ON po.id = rep.reply_id group by rep.reply_id")}

	def set_subject
		if self.reply_id && self.subject == ""
			self.subject = "回文"
		end
	end

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
