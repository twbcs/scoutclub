class Board < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :user_id, :on => :create, :message => "不可為空"
	validates_presence_of :content, :on => :create, :message => "不可為空"		
end