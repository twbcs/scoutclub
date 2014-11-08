class Photo < ActiveRecord::Base
  include Right
  belongs_to :user
  belongs_to :album
  mount_uploader :file, ImageUploader

  include Rails.application.routes.url_helpers
  def to_jq_upload
    {
      "name"        => read_attribute(:name),
      "size"        => read_attribute(:size),
      "url"         => self.file_url(),
      "small_url"   => self.file_url(:small),
      "delete_url"  => upload_photo_path(self),
      "delete_type" => "DELETE"
    }
  end
end
