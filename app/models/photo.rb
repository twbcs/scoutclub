class Photo < ActiveRecord::Base
  include Right
  belongs_to :user
  mount_uploader :file, ImageUploader

end
