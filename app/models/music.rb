class Music < ActiveRecord::Base
  include Right
  belongs_to :user
  mount_uploader :file, MusicUploader

  validates_presence_of :title, :on => :create, :message => "不可為空"

end
