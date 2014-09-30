class Group < ActiveRecord::Base
  has_many :group_forums, :dependent => :destroy
  has_many :forums, :through => :group_forums
  has_many :user_groups, :dependent => :destroy
  has_many :users, :through => :user_groups
  #code

end
