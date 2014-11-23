class Member < ActiveRecord::Base
	has_many :title_ths, :dependent => :destroy
	has_many :titles, :through => :title_ths
	accepts_nested_attributes_for :title_ths, :reject_if => lambda { |a| a[:title_year].blank? }, :allow_destroy => true
	validates_presence_of :name, :on => :create, :message => "不能為空"
	scope :order_by_year, -> { order( year: :asc)}
end
