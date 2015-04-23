class Movie < ActiveRecord::Base
  include Right

  belongs_to :user
  delegate :name, to: :user, prefix: 'user'
  scope :order_by_time, -> { order(created_at: :desc) }
  scope :page_set, -> { includes(:user).paginate(page: params[:page], per_page: 20) }

  validates_presence_of :title, on: :create, message: '不能為空'
  validates_presence_of :url, on: :create, message: '不能為空'
end
