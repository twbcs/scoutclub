class Forum < ActiveRecord::Base
  has_many :posts
  has_many :group_forums
  has_many :groups, through: :group_forums
  belongs_to :forum_kind
  delegate :title, to: :forum_kind, prefix: true

  validates_presence_of :title, on: :create, message: '不能為空'
  scope :order_by_forum_kind, -> { order(forum_kind_id: :asc) }
end
