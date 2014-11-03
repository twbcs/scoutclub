class Music < ActiveRecord::Base
  include Right
  belongs_to :user
  mount_uploader :file, MusicUploader

end
