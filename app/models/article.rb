class Article < ActiveRecord::Base
  include Right

  belongs_to :user
  delegate :name, to: :user, prefix: 'user'
  belongs_to :art_kind
  has_many :comments, dependent: :destroy

  validates_presence_of :title, on: :create, message: '不能為空'
  validates_presence_of :art_kind_id, on: :create, message: '必須選擇一個'
  validates_presence_of :content, on: :create, message: '不能為空'
  scope :order_by_time, -> { order(created_at: :desc) }
  scope :page_set, -> page { paginate(page: page, per_page: 10) }
end
