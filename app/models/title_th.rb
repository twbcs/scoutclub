class TitleTh < ActiveRecord::Base
	belongs_to :title
	delegate :title,		 :to => :title, :prefix => true
	belongs_to :member
	delegate :name, :th, :to => :member, :prefix => true

	accepts_nested_attributes_for :title

	scope :order_by_title, -> { order('titles.level ASC') }
	scope :order_by_year, -> { order( title_year: :asc) }
end
