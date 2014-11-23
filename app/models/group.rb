class Group < ActiveRecord::Base
  has_many :group_forums, :dependent => :destroy
  has_many :forums, :through => :group_forums
  has_many :user_groups, :dependent => :destroy
  has_many :users, :through => :user_groups

  validates_presence_of :name, :on => :create, :message => "不能為空"
end
