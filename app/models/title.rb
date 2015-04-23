class Title < ActiveRecord::Base
  has_many :title_ths
  has_many :members, through: :title_ths
  validates_presence_of :title, on: :create, message: '不能為空'
  scope :order_by_level, -> { order(level: :asc) }
end
