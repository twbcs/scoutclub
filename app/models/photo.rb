class Photo < ActiveRecord::Base
  include Right
  belongs_to :user
  belongs_to :album
  mount_uploader :file, ImageUploader

end
