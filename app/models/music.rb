class Music < ActiveRecord::Base
  include Right
  belongs_to :user
  mount_uploader :file, MusicUploader

  scope :page_set, -> { includes(:user).paginate(page: params[:page], per_page: 20) }

  validates_presence_of :title, on: :create, message: '不可為空'
end
