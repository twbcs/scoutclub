class Movie < ActiveRecord::Base
  include Right

  belongs_to :user
  delegate :name, to: :user, prefix: "user"
  scope :order_by_time, -> { order(created_at: :desc) }

  validates_presence_of :title, :on => :create, :message => "can't be blank"
  validates_presence_of :url, :on => :create, :message => "can't be blank"
end
